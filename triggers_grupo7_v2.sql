-- ============================================================
-- 02_TRIGGERS_GRUPO7_V2.SQL
-- Proyecto Clubes de Lectura - Grupo 7 ACJJ
-- NRC 25758 - Prof. Lucia Cardoso - 2026
-- 10 triggers corregidos
-- Correcciones aplicadas:
--   - id_club_g -> id_club en ACJJ_GRUPOS_LECTORES (TRG-01,04,06,09,10)
--   - id_moderador -> mod_id_lector en ACJJ_CALENDARIOS_MES (TRG-09)
--   - TO_CHAR(dia,'D') -> TO_CHAR(dia,'DY','NLS_DATE_LANGUAGE=ENGLISH') (TRG-07)
--   - TRG-03: id_pago calculado con MAX en lugar de hardcodeado a 1
--   - TRG-09: ampliado a BEFORE INSERT OR UPDATE
-- ============================================================
SET DEFINE OFF;

-- ============================================================
-- TRG-01: Validar edad del lector vs tipo de grupo
-- Tabla: ACJJ_GRUPOS_LECTORES (BEFORE INSERT)
-- Regla: I=6-12, J=13-25, A>25
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_VALIDAR_EDAD_GRUPO
BEFORE INSERT ON ACJJ_GRUPOS_LECTORES
FOR EACH ROW
DECLARE
    v_fecha_nac DATE;
    v_edad      NUMBER;
    v_tipo      VARCHAR2(1);
BEGIN
    SELECT fecha_nac INTO v_fecha_nac
    FROM ACJJ_LECTORES WHERE id_lector = :NEW.id_lector;

    SELECT tipo INTO v_tipo
    FROM ACJJ_GRUPOS_DE_LECTURA
    WHERE id_club = :NEW.id_club AND id_grupo = :NEW.id_grupo;

    v_edad := TRUNC(MONTHS_BETWEEN(SYSDATE, v_fecha_nac) / 12);

    IF v_tipo = 'I' AND (v_edad < 6 OR v_edad > 12) THEN
        RAISE_APPLICATION_ERROR(-20001,
            'TRG-01 ERROR: Lector ' || :NEW.id_lector ||
            ' tiene ' || v_edad || ' anos. Grupo infantil requiere 6-12 anos.');
    ELSIF v_tipo = 'J' AND (v_edad < 13 OR v_edad > 25) THEN
        RAISE_APPLICATION_ERROR(-20002,
            'TRG-01 ERROR: Lector ' || :NEW.id_lector ||
            ' tiene ' || v_edad || ' anos. Grupo juvenil requiere 13-25 anos.');
    ELSIF v_tipo = 'A' AND v_edad <= 25 THEN
        RAISE_APPLICATION_ERROR(-20003,
            'TRG-01 ERROR: Lector ' || :NEW.id_lector ||
            ' tiene ' || v_edad || ' anos. Grupo adulto requiere mas de 25 anos.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20004,
            'TRG-01 ERROR: Lector o grupo no encontrado.');
END ACJJ_TRG_VALIDAR_EDAD_GRUPO;
/

-- ============================================================
-- TRG-02: Validar que el lector no tenga deudas en clubes anteriores
-- Tabla: ACJJ_MEMBRESIAS (BEFORE INSERT)
-- Regla: pagos_realizados >= ceil(meses_en_club / 12)
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_VALIDAR_DEUDA
BEFORE INSERT ON ACJJ_MEMBRESIAS
FOR EACH ROW
DECLARE
    v_deuda NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO   v_deuda
    FROM   ACJJ_MEMBRESIAS m
    JOIN   ACJJ_CLUBES_DE_LECTURA c ON c.id_club = m.id_club
    WHERE  m.id_lector      = :NEW.id_lector
    AND    m.id_club        != :NEW.id_club
    AND    c.tiene_membresia = 'S'
    AND   (SELECT COUNT(*)
           FROM   ACJJ_PAGOS p
           WHERE  p.id_lector    = m.id_lector
           AND    p.id_club      = m.id_club
           AND    p.id_membresia = m.id_membresia)
          < CEIL(MONTHS_BETWEEN(NVL(m.fecha_retiro, SYSDATE), m.fecha_ingreso) / 12);

    IF v_deuda > 0 THEN
        RAISE_APPLICATION_ERROR(-20010,
            'TRG-02 ERROR: Lector ' || :NEW.id_lector ||
            ' tiene pagos pendientes en uno o mas clubes anteriores. ' ||
            'Salde sus deudas antes de unirse a un nuevo club.');
    END IF;
END ACJJ_TRG_VALIDAR_DEUDA;
/

-- ============================================================
-- TRG-03: Crear primer pago automaticamente al registrar membresia
-- Tabla: ACJJ_MEMBRESIAS (AFTER INSERT)
-- Regla: solo clubes con tiene_membresia = 'S'
-- Corrección: id_pago calculado con MAX+1 en lugar de hardcodeado a 1
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_AUTO_PAGO
AFTER INSERT ON ACJJ_MEMBRESIAS
FOR EACH ROW
DECLARE
    v_tiene_membresia VARCHAR2(1);
    v_num_pagos       NUMBER;
BEGIN
    SELECT tiene_membresia
    INTO   v_tiene_membresia
    FROM   ACJJ_CLUBES_DE_LECTURA
    WHERE  id_club = :NEW.id_club;

    IF v_tiene_membresia = 'S' THEN
        SELECT NVL(MAX(id_pago), 0)
        INTO   v_num_pagos
        FROM   ACJJ_PAGOS
        WHERE  id_lector    = :NEW.id_lector
        AND    id_club      = :NEW.id_club
        AND    id_membresia = :NEW.id_membresia;

        INSERT INTO ACJJ_PAGOS
            (id_lector, id_club, id_membresia, id_pago, fecha_pago)
        VALUES
            (:NEW.id_lector, :NEW.id_club, :NEW.id_membresia,
             v_num_pagos + 1, SYSDATE);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN NULL;
    WHEN DUP_VAL_ON_INDEX THEN NULL;
END ACJJ_TRG_AUTO_PAGO;
/

-- ============================================================
-- TRG-04: Bloquear ingreso de miembro si el grupo tiene libro en discusion
-- Tabla: ACJJ_GRUPOS_LECTORES (BEFORE INSERT)
-- Regla: no nuevo integrante ni split mientras se discute un libro
-- Corrección: id_club_g -> id_club
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_BLOQUEAR_INGRESO_DISCUSION
BEFORE INSERT ON ACJJ_GRUPOS_LECTORES
FOR EACH ROW
DECLARE
    v_en_discusion NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_en_discusion
    FROM   ACJJ_CALENDARIOS_MES
    WHERE  id_grupo = :NEW.id_grupo
    AND    id_club  = :NEW.id_club
    AND    (ult_reunion IS NULL OR ult_reunion = 'N');

    IF v_en_discusion > 0 THEN
        RAISE_APPLICATION_ERROR(-20020,
            'TRG-04 ERROR: No se puede agregar miembros al grupo ' ||
            :NEW.id_grupo || ' del club ' || :NEW.id_club ||
            '. Hay un libro en discusion activa. ' ||
            'Espere a que concluya la discusion actual.');
    END IF;
END ACJJ_TRG_BLOQUEAR_INGRESO_DISCUSION;
/

-- ============================================================
-- TRG-05: Cobro adicional si el retiro no se comunica con 1 mes de anticipacion
-- Tabla: ACJJ_MEMBRESIAS (BEFORE UPDATE)
-- Regla: si avisa con <30 dias del siguiente aniversario, se genera un pago extra
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_VALIDAR_RETIRO
BEFORE UPDATE ON ACJJ_MEMBRESIAS
FOR EACH ROW
WHEN (NEW.estatus = 'I' AND OLD.estatus = 'A' AND NEW.fecha_retiro IS NOT NULL)
DECLARE
    v_ultimo_pago       DATE;
    v_prox_aniversario  DATE;
    v_dias_anticipacion NUMBER;
    v_num_pagos         NUMBER;
    v_tiene_membresia   VARCHAR2(1);
BEGIN
    SELECT tiene_membresia INTO v_tiene_membresia
    FROM   ACJJ_CLUBES_DE_LECTURA
    WHERE  id_club = :NEW.id_club;

    IF v_tiene_membresia = 'S' THEN
        SELECT NVL(MAX(fecha_pago), :OLD.fecha_ingreso)
        INTO   v_ultimo_pago
        FROM   ACJJ_PAGOS
        WHERE  id_lector    = :NEW.id_lector
        AND    id_club      = :NEW.id_club
        AND    id_membresia = :NEW.id_membresia;

        v_prox_aniversario  := ADD_MONTHS(v_ultimo_pago, 12);
        v_dias_anticipacion := v_prox_aniversario - :NEW.fecha_retiro;

        IF v_dias_anticipacion < 30 THEN
            SELECT NVL(MAX(id_pago), 0) INTO v_num_pagos
            FROM   ACJJ_PAGOS
            WHERE  id_lector    = :NEW.id_lector
            AND    id_club      = :NEW.id_club
            AND    id_membresia = :NEW.id_membresia;

            INSERT INTO ACJJ_PAGOS
                (id_lector, id_club, id_membresia, id_pago, fecha_pago)
            VALUES
                (:NEW.id_lector, :NEW.id_club, :NEW.id_membresia,
                 v_num_pagos + 1, v_prox_aniversario);
        END IF;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN NULL;
END ACJJ_TRG_VALIDAR_RETIRO;
/

-- ============================================================
-- TRG-06: Bloquear ingreso cuando el grupo supera su capacidad maxima
-- Tabla: ACJJ_GRUPOS_LECTORES (BEFORE INSERT)
-- Regla: Adultos <= 30, Infantil/Juvenil <= 15
-- Corrección: id_club_g -> id_club en todos los sitios
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_LIMITE_GRUPO
BEFORE INSERT ON ACJJ_GRUPOS_LECTORES
FOR EACH ROW
DECLARE
    v_tipo    VARCHAR2(1);
    v_activos NUMBER;
    v_limite  NUMBER;
BEGIN
    SELECT tipo INTO v_tipo
    FROM   ACJJ_GRUPOS_DE_LECTURA
    WHERE  id_club = :NEW.id_club AND id_grupo = :NEW.id_grupo;

    SELECT COUNT(*) INTO v_activos
    FROM   ACJJ_GRUPOS_LECTORES
    WHERE  id_grupo  = :NEW.id_grupo
    AND    id_club   = :NEW.id_club
    AND    fecha_fin IS NULL;

    v_limite := CASE v_tipo WHEN 'A' THEN 30 ELSE 15 END;

    IF v_activos >= v_limite THEN
        RAISE_APPLICATION_ERROR(-20030,
            'TRG-06 ERROR: El grupo ' || :NEW.id_grupo ||
            ' del club ' || :NEW.id_club ||
            ' ha alcanzado su limite de ' || v_limite || ' miembros (' ||
            v_tipo || '). Realice un split primero.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN NULL;
END ACJJ_TRG_LIMITE_GRUPO;
/

-- ============================================================
-- TRG-07: Validar horario de reunion (Lun-Vie, 17:00-19:00)
-- Tabla: ACJJ_GRUPOS_DE_LECTURA (BEFORE INSERT OR UPDATE)
-- Corrección: TO_CHAR con NLS_DATE_LANGUAGE=ENGLISH para evitar
--             dependencia de NLS_TERRITORY de la sesion
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_VALIDAR_HORARIO
BEFORE INSERT OR UPDATE ON ACJJ_GRUPOS_DE_LECTURA
FOR EACH ROW
DECLARE
    v_hora NUMBER;
    v_dia  VARCHAR2(3);
BEGIN
    v_hora := TO_NUMBER(TO_CHAR(:NEW.hora_ini_reu, 'HH24')) +
              TO_NUMBER(TO_CHAR(:NEW.hora_ini_reu, 'MI')) / 60;

    v_dia := TO_CHAR(:NEW.dia_reunion, 'DY',
                     'NLS_DATE_LANGUAGE=ENGLISH');

    IF v_dia NOT IN ('MON','TUE','WED','THU','FRI') THEN
        RAISE_APPLICATION_ERROR(-20040,
            'TRG-07 ERROR: Las reuniones solo pueden ser de lunes a viernes.');
    END IF;

    IF v_hora < 17 THEN
        RAISE_APPLICATION_ERROR(-20041,
            'TRG-07 ERROR: La reunion no puede empezar antes de las 17:00.');
    END IF;

    IF v_hora >= 19 THEN
        RAISE_APPLICATION_ERROR(-20042,
            'TRG-07 ERROR: La reunion no puede empezar a las 19:00 o despues.');
    END IF;
END ACJJ_TRG_VALIDAR_HORARIO;
/

-- ============================================================
-- TRG-08: Grupos infantiles deben terminar antes de las 19:00
-- Tabla: ACJJ_GRUPOS_DE_LECTURA (BEFORE INSERT OR UPDATE)
-- Regla: tipo='I' -> hora_ini_reu <= 17:00 (duracion max 2h -> fin <= 19:00)
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_HORARIO_INFANTIL
BEFORE INSERT OR UPDATE ON ACJJ_GRUPOS_DE_LECTURA
FOR EACH ROW
WHEN (NEW.tipo = 'I')
DECLARE
    v_hora NUMBER;
BEGIN
    v_hora := TO_NUMBER(TO_CHAR(:NEW.hora_ini_reu, 'HH24')) +
              TO_NUMBER(TO_CHAR(:NEW.hora_ini_reu, 'MI')) / 60;

    IF v_hora > 17 THEN
        RAISE_APPLICATION_ERROR(-20050,
            'TRG-08 ERROR: Los grupos infantiles deben iniciar a las 17:00 ' ||
            'como maximo para terminar antes de las 19:00 ' ||
            '(duracion maxima 2 horas).');
    END IF;
END ACJJ_TRG_HORARIO_INFANTIL;
/

-- ============================================================
-- TRG-09: Validar que el moderador pertenece al grupo correcto
-- Tabla: ACJJ_CALENDARIOS_MES (BEFORE INSERT OR UPDATE)
-- Regla: grupos I/J -> moderador debe ser de grupo A del mismo club
--        grupo A   -> moderador debe pertenecer al mismo grupo
-- Correcciones:
--   - id_club_g -> id_club en ACJJ_GRUPOS_LECTORES
--   - id_moderador -> mod_id_lector (nombre real de columna en CALENDARIOS_MES)
--   - ampliado a BEFORE INSERT OR UPDATE
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_VALIDAR_MODERADOR
BEFORE INSERT OR UPDATE ON ACJJ_CALENDARIOS_MES
FOR EACH ROW
DECLARE
    v_tipo_grupo VARCHAR2(1);
    v_es_valido  NUMBER;
BEGIN
    SELECT tipo INTO v_tipo_grupo
    FROM   ACJJ_GRUPOS_DE_LECTURA
    WHERE  id_club = :NEW.id_club AND id_grupo = :NEW.id_grupo;

    IF v_tipo_grupo IN ('I', 'J') THEN
        SELECT COUNT(*) INTO v_es_valido
        FROM   ACJJ_GRUPOS_LECTORES gl
        JOIN   ACJJ_GRUPOS_DE_LECTURA gd
               ON gd.id_grupo = gl.id_grupo AND gd.id_club = gl.id_club
        WHERE  gl.id_lector = :NEW.mod_id_lector
        AND    gl.id_club   = :NEW.id_club
        AND    gd.tipo      = 'A'
        AND    gl.fecha_fin IS NULL;
    ELSE
        SELECT COUNT(*) INTO v_es_valido
        FROM   ACJJ_GRUPOS_LECTORES
        WHERE  id_lector = :NEW.mod_id_lector
        AND    id_grupo  = :NEW.id_grupo
        AND    id_club   = :NEW.id_club
        AND    fecha_fin IS NULL;
    END IF;

    IF v_es_valido = 0 THEN
        RAISE_APPLICATION_ERROR(-20060,
            'TRG-09 ERROR: El moderador ' || :NEW.mod_id_lector ||
            ' no puede moderar el grupo ' || :NEW.id_grupo ||
            ' del club ' || :NEW.id_club ||
            '. No cumple con los requisitos de pertenencia.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20061,
            'TRG-09 ERROR: Grupo o moderador no encontrado.');
END ACJJ_TRG_VALIDAR_MODERADOR;
/

-- ============================================================
-- TRG-10: Expulsion automatica por mas del 30% de inasistencias en un bimestre
-- Tablas: ACJJ_INASISTENCIAS, ACJJ_MEMBRESIAS, ACJJ_GRUPOS_LECTORES
-- Correcciones aplicadas v3:
--   - ORA-04091 resuelto: separado en paquete + trigger ROW + trigger STMT
--   - El trigger de fila ya NO lee ACJJ_INASISTENCIAS (evita tabla mutando)
--   - El trigger de statement lee la tabla cuando ya esta estable
--   - Logica de negocio identica al TRG-10 original de Carmelo
-- ============================================================

-- Paquete auxiliar: actua como memoria temporal entre ambos triggers
CREATE OR REPLACE PACKAGE ACJJ_PKG_EXPULSION AS
    TYPE t_key IS RECORD (
        id_lector    NUMBER,
        id_club      NUMBER,
        id_grupo     NUMBER,
        id_membresia NUMBER,
        cal_fecha    DATE,
        fecha_ini_gl DATE
    );
    TYPE t_keys IS TABLE OF t_key INDEX BY PLS_INTEGER;
    g_pending t_keys;
    g_count   PLS_INTEGER := 0;
END ACJJ_PKG_EXPULSION;
/

-- Trigger de FILA: captura los datos del INSERT, no lee la tabla
CREATE OR REPLACE TRIGGER ACJJ_TRG_AUTO_EXPULSION_ROW
AFTER INSERT ON ACJJ_INASISTENCIAS
FOR EACH ROW
BEGIN
    ACJJ_PKG_EXPULSION.g_count := ACJJ_PKG_EXPULSION.g_count + 1;
    ACJJ_PKG_EXPULSION.g_pending(ACJJ_PKG_EXPULSION.g_count).id_lector    := :NEW.id_lector;
    ACJJ_PKG_EXPULSION.g_pending(ACJJ_PKG_EXPULSION.g_count).id_club      := :NEW.id_club;
    ACJJ_PKG_EXPULSION.g_pending(ACJJ_PKG_EXPULSION.g_count).id_grupo     := :NEW.id_grupo;
    ACJJ_PKG_EXPULSION.g_pending(ACJJ_PKG_EXPULSION.g_count).id_membresia := :NEW.id_membresia;
    ACJJ_PKG_EXPULSION.g_pending(ACJJ_PKG_EXPULSION.g_count).cal_fecha    := :NEW.cal_fecha;
    ACJJ_PKG_EXPULSION.g_pending(ACJJ_PKG_EXPULSION.g_count).fecha_ini_gl := :NEW.fecha_ini_gl;
END ACJJ_TRG_AUTO_EXPULSION_ROW;
/

-- Trigger de STATEMENT: aqui si puede leer ACJJ_INASISTENCIAS con seguridad
-- Contiene la logica identica al TRG-10 original de Carmelo
CREATE OR REPLACE TRIGGER ACJJ_TRG_AUTO_EXPULSION_STMT
AFTER INSERT ON ACJJ_INASISTENCIAS
DECLARE
    v_mes_num       NUMBER;
    v_mes_inicio    NUMBER;
    v_fecha_ini_bim DATE;
    v_fecha_fin_bim DATE;
    v_total_reu     NUMBER;
    v_total_inas    NUMBER;
    v_porcentaje    NUMBER;
    r               ACJJ_PKG_EXPULSION.t_key;
BEGIN
    FOR i IN 1 .. ACJJ_PKG_EXPULSION.g_count LOOP
        r := ACJJ_PKG_EXPULSION.g_pending(i);

        v_mes_num    := TO_NUMBER(TO_CHAR(r.cal_fecha, 'MM'));
        v_mes_inicio := CASE WHEN MOD(v_mes_num, 2) = 0
                             THEN v_mes_num - 1
                             ELSE v_mes_num END;

        v_fecha_ini_bim := TO_DATE(
            '01/' || LPAD(TO_CHAR(v_mes_inicio), 2, '0') || '/' ||
            TO_CHAR(r.cal_fecha, 'YYYY'), 'DD/MM/YYYY');
        v_fecha_fin_bim := ADD_MONTHS(v_fecha_ini_bim, 2) - 1;

        SELECT COUNT(*) INTO v_total_reu
        FROM   ACJJ_CALENDARIOS_MES
        WHERE  id_grupo  = r.id_grupo
        AND    id_club   = r.id_club
        AND    realizado = 'S'
        AND    fecha     BETWEEN v_fecha_ini_bim AND v_fecha_fin_bim;

        SELECT COUNT(*) INTO v_total_inas
        FROM   ACJJ_INASISTENCIAS
        WHERE  id_lector = r.id_lector
        AND    id_grupo  = r.id_grupo
        AND    id_club   = r.id_club
        AND    cal_fecha BETWEEN v_fecha_ini_bim AND v_fecha_fin_bim;

        IF v_total_reu > 0 THEN
            v_porcentaje := (v_total_inas / v_total_reu) * 100;

            IF v_porcentaje > 30 THEN
                UPDATE ACJJ_MEMBRESIAS
                SET    estatus       = 'I',
                       fecha_retiro  = SYSDATE,
                       motivo_retiro = 'Expulsado automaticamente: ' ||
                           ROUND(v_porcentaje, 1) || '% inasistencias en bimestre ' ||
                           TO_CHAR(v_fecha_ini_bim, 'MM/YYYY') || '-' ||
                           TO_CHAR(v_fecha_fin_bim, 'MM/YYYY')
                WHERE  id_lector    = r.id_lector
                AND    id_club      = r.id_club
                AND    id_membresia = r.id_membresia
                AND    estatus      = 'A';

                UPDATE ACJJ_GRUPOS_LECTORES
                SET    fecha_fin = SYSDATE
                WHERE  id_lector    = r.id_lector
                AND    id_grupo     = r.id_grupo
                AND    id_club      = r.id_club
                AND    id_membresia = r.id_membresia
                AND    fecha_fin    IS NULL;
            END IF;
        END IF;
    END LOOP;

    -- Limpiar buffer para la proxima transaccion
    ACJJ_PKG_EXPULSION.g_count := 0;
    ACJJ_PKG_EXPULSION.g_pending.DELETE;
END ACJJ_TRG_AUTO_EXPULSION_STMT;
/

COMMIT;
-- FIN TRIGGERS CORREGIDOS - 10 triggers
-- ============================================================
-- TRG-11: Bloquear que un lector este activo en mas de un club
-- Tabla: ACJJ_MEMBRESIAS (BEFORE INSERT)
-- Regla: un miembro no puede tener estatus='A' en mas de un club
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_UN_CLUB_ACTIVO
BEFORE INSERT ON ACJJ_MEMBRESIAS
FOR EACH ROW
DECLARE
    v_clubs_activos NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_clubs_activos
    FROM   ACJJ_MEMBRESIAS
    WHERE  id_lector = :NEW.id_lector
    AND    estatus   = 'A';

    IF v_clubs_activos > 0 THEN
        RAISE_APPLICATION_ERROR(-20070,
            'TRG-11 ERROR: Lector ' || :NEW.id_lector ||
            ' ya tiene una membresia activa en otro club. ' ||
            'Debe retirarse antes de unirse a uno nuevo.');
    END IF;
END ACJJ_TRG_UN_CLUB_ACTIVO;
/

-- ============================================================
-- TRG-12: Bloquear moderador asignado simultaneamente a mas de un grupo
-- Tabla: ACJJ_CALENDARIOS_MES (BEFORE INSERT OR UPDATE)
-- Regla: un moderador no puede tener reuniones activas (ult_reunion='N'
--        o IS NULL) en mas de un grupo al mismo tiempo
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_MODERADOR_UN_GRUPO
BEFORE INSERT OR UPDATE ON ACJJ_CALENDARIOS_MES
FOR EACH ROW
DECLARE
    v_grupos_activos NUMBER;
BEGIN
    SELECT COUNT(DISTINCT id_grupo || '-' || id_club)
    INTO   v_grupos_activos
    FROM   ACJJ_CALENDARIOS_MES
    WHERE  mod_id_lector   = :NEW.mod_id_lector
    AND    mod_id_club     = :NEW.mod_id_club
    AND    (ult_reunion IS NULL OR ult_reunion = 'N')
    AND    NOT (id_grupo = :NEW.id_grupo AND id_club = :NEW.id_club);

    IF v_grupos_activos > 0 THEN
        RAISE_APPLICATION_ERROR(-20080,
            'TRG-12 ERROR: El moderador ' || :NEW.mod_id_lector ||
            ' ya esta moderando otro grupo activo en el club ' || :NEW.id_club ||
            '. Debe concluir esa discusion antes de moderar otro grupo.');
    END IF;
END ACJJ_TRG_MODERADOR_UN_GRUPO;
/

-- ============================================================
-- TRG-13: Bloquear reingreso al mismo club tras expulsion por inasistencias
-- Tabla: ACJJ_MEMBRESIAS (BEFORE INSERT)
-- Regla: motivo_retiro que empiece con 'Expulsado automaticamente'
--        impide volver al mismo club
-- ============================================================
CREATE OR REPLACE TRIGGER ACJJ_TRG_BLOQUEAR_REINGRESO
BEFORE INSERT ON ACJJ_MEMBRESIAS
FOR EACH ROW
DECLARE
    v_expulsado NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO   v_expulsado
    FROM   ACJJ_MEMBRESIAS
    WHERE  id_lector = :NEW.id_lector
    AND    id_club   = :NEW.id_club
    AND    motivo_retiro LIKE 'Expulsado automaticamente%';

    IF v_expulsado > 0 THEN
        RAISE_APPLICATION_ERROR(-20090,
            'TRG-13 ERROR: Lector ' || :NEW.id_lector ||
            ' fue expulsado del club ' || :NEW.id_club ||
            ' por inasistencias y no puede volver a unirse.');
    END IF;
END ACJJ_TRG_BLOQUEAR_REINGRESO;
/

COMMIT;
