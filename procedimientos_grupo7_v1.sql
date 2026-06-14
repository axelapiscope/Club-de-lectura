-- ============================================================
-- PROCEDIMIENTOS_GRUPO7_V1.SQL
-- Proyecto Clubes de Lectura - Grupo 7 ACJJ
-- NRC 25758 - Prof. Lucia Cardoso - 2026
-- JOSE: Administracion de Clubes (SP1-SP4)
-- JAVIER: Administracion de Reuniones (SP5-SP8)
-- Reglas: cero hardcoded, manejo de excepciones obligatorio
-- ============================================================

-- ============================================================
-- [JOSE - SP1] Inscribir miembro en un club
-- Tabla principal: ACJJ_MEMBRESIAS
-- Reglas que ya cubren los triggers:
--   TRG-02: sin deudas, TRG-11: un solo club activo
-- Este procedimiento: crea la membresia y asigna al grupo correcto
-- segun la edad del lector (llama a edad_miembro())
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_INSCRIBIR_MIEMBRO (
    p_id_lector    IN  ACJJ_LECTORES.id_lector%TYPE,
    p_id_club      IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_membresia OUT ACJJ_MEMBRESIAS.id_membresia%TYPE,
    p_id_grupo     OUT ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_mensaje      OUT VARCHAR2
) AS
    v_edad         NUMBER;
    v_tipo_grupo   VARCHAR2(1);
    v_id_membresia NUMBER;
    v_id_grupo     NUMBER;
    v_existe_club  NUMBER;
    v_existe_lector NUMBER;
BEGIN
    -- Validar que el club existe
    SELECT COUNT(*) INTO v_existe_club
    FROM   ACJJ_CLUBES_DE_LECTURA
    WHERE  id_club = p_id_club;

    IF v_existe_club = 0 THEN
        p_mensaje := 'ERROR: El club ' || p_id_club || ' no existe.';
        RETURN;
    END IF;

    -- Validar que el lector existe
    SELECT COUNT(*) INTO v_existe_lector
    FROM   ACJJ_LECTORES
    WHERE  id_lector = p_id_lector;

    IF v_existe_lector = 0 THEN
        p_mensaje := 'ERROR: El lector ' || p_id_lector || ' no existe.';
        RETURN;
    END IF;

    -- Determinar tipo de grupo segun edad (usa funcion de Carmelo)
    v_edad := edad_miembro(p_id_lector);

    v_tipo_grupo := CASE
        WHEN v_edad BETWEEN 6  AND 12 THEN 'I'
        WHEN v_edad BETWEEN 13 AND 25 THEN 'J'
        WHEN v_edad > 25              THEN 'A'
        ELSE NULL
    END;

    IF v_tipo_grupo IS NULL THEN
        p_mensaje := 'ERROR: El lector tiene ' || v_edad ||
                     ' anos. Edad no valida para ningun grupo (minimo 6 anos).';
        RETURN;
    END IF;

    -- Buscar grupo disponible del tipo correcto en el club
    -- (que no este en discusion activa y no haya alcanzado el limite)
    SELECT id_grupo INTO v_id_grupo
    FROM   ACJJ_GRUPOS_DE_LECTURA
    WHERE  id_club = p_id_club
    AND    tipo    = v_tipo_grupo
    AND    id_grupo NOT IN (
               SELECT id_grupo FROM ACJJ_CALENDARIOS_MES
               WHERE  id_club = p_id_club
               AND    (ult_reunion IS NULL OR ult_reunion = 'N')
           )
    AND   (SELECT COUNT(*) FROM ACJJ_GRUPOS_LECTORES gl
           WHERE  gl.id_club   = p_id_club
           AND    gl.id_grupo  = ACJJ_GRUPOS_DE_LECTURA.id_grupo
           AND    gl.fecha_fin IS NULL)
          < CASE v_tipo_grupo WHEN 'A' THEN 30 ELSE 15 END
    AND ROWNUM = 1;

    -- Calcular nuevo id_membresia
    SELECT NVL(MAX(id_membresia), 0) + 1
    INTO   v_id_membresia
    FROM   ACJJ_MEMBRESIAS
    WHERE  id_club = p_id_club;

    -- Insertar membresia (TRG-02 y TRG-11 validan automaticamente)
    INSERT INTO ACJJ_MEMBRESIAS
        (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
    VALUES
        (p_id_lector, p_id_club, v_id_membresia, SYSDATE, 'A');

    -- Insertar en el grupo (TRG-01, TRG-04, TRG-06 validan automaticamente)
    INSERT INTO ACJJ_GRUPOS_LECTORES
        (id_lector, fecha_inicio, id_grupo, id_club, id_membresia)
    VALUES
        (p_id_lector, SYSDATE, v_id_grupo, p_id_club, v_id_membresia);

    -- Retornar valores al caller
    p_id_membresia := v_id_membresia;
    p_id_grupo     := v_id_grupo;
    p_mensaje      := 'OK: Lector ' || p_id_lector ||
                      ' inscrito en club ' || p_id_club ||
                      ', grupo ' || v_id_grupo ||
                      ', membresia ' || v_id_membresia || '.';
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        p_mensaje := 'ERROR: No hay grupos disponibles de tipo ' ||
                     v_tipo_grupo || ' en el club ' || p_id_club ||
                     '. Todos estan en discusion activa o al limite de capacidad.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_INSCRIBIR_MIEMBRO: ' || SQLERRM;
END ACJJ_SP_INSCRIBIR_MIEMBRO;
/

-- ============================================================
-- [JOSE - SP2] Division automatica de grupo (split)
-- Tabla principal: ACJJ_GRUPOS_LECTORES, ACJJ_GRUPOS_DE_LECTURA
-- Regla: los mas antiguos se quedan, los nuevos van al grupo nuevo
--        No se puede hacer split si hay libro en discusion (TRG-04)
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_DIVIDIR_GRUPO (
    p_id_club       IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_grupo_orig IN  ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_id_grupo_nuevo OUT ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_mensaje        OUT VARCHAR2
) AS
    v_tipo          VARCHAR2(1);
    v_dia_reunion   DATE;
    v_hora_ini_reu  DATE;
    v_total         NUMBER;
    v_limite        NUMBER;
    v_nuevo_grupo   NUMBER;
    v_mitad         NUMBER;

    CURSOR c_miembros_nuevos IS
        SELECT id_lector, fecha_inicio, id_membresia
        FROM   ACJJ_GRUPOS_LECTORES
        WHERE  id_club   = p_id_club
        AND    id_grupo  = p_id_grupo_orig
        AND    fecha_fin IS NULL
        ORDER  BY fecha_inicio DESC; -- los mas nuevos se van
BEGIN
    -- Obtener datos del grupo original
    SELECT tipo, dia_reunion, hora_ini_reu
    INTO   v_tipo, v_dia_reunion, v_hora_ini_reu
    FROM   ACJJ_GRUPOS_DE_LECTURA
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo_orig;

    -- Verificar que no haya libro en discusion activa
    SELECT COUNT(*) INTO v_total
    FROM   ACJJ_CALENDARIOS_MES
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo_orig
    AND    (ult_reunion IS NULL OR ult_reunion = 'N');

    IF v_total > 0 THEN
        p_mensaje := 'ERROR: No se puede dividir el grupo ' || p_id_grupo_orig ||
                     '. Hay un libro en discusion activa.';
        RETURN;
    END IF;

    -- Verificar que el grupo supera el limite
    v_limite := CASE v_tipo WHEN 'A' THEN 30 ELSE 15 END;

    SELECT COUNT(*) INTO v_total
    FROM   ACJJ_GRUPOS_LECTORES
    WHERE  id_club   = p_id_club
    AND    id_grupo  = p_id_grupo_orig
    AND    fecha_fin IS NULL;

    IF v_total <= v_limite THEN
        p_mensaje := 'ERROR: El grupo ' || p_id_grupo_orig ||
                     ' tiene ' || v_total || ' miembros. ' ||
                     'Solo se divide cuando supera ' || v_limite || '.';
        RETURN;
    END IF;

    -- Calcular id del nuevo grupo
    SELECT NVL(MAX(id_grupo), 0) + 1
    INTO   v_nuevo_grupo
    FROM   ACJJ_GRUPOS_DE_LECTURA
    WHERE  id_club = p_id_club;

    -- Crear el nuevo grupo con los mismos parametros
    INSERT INTO ACJJ_GRUPOS_DE_LECTURA
        (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
    VALUES
        (p_id_club, v_nuevo_grupo, v_tipo, SYSDATE, v_dia_reunion, v_hora_ini_reu);

    -- Mover la mitad mas nueva al grupo nuevo
    v_mitad := CEIL(v_total / 2);

    FOR r IN c_miembros_nuevos LOOP
        EXIT WHEN v_mitad = 0;

        -- Cerrar en grupo original
        UPDATE ACJJ_GRUPOS_LECTORES
        SET    fecha_fin = SYSDATE
        WHERE  id_lector    = r.id_lector
        AND    id_club      = p_id_club
        AND    id_grupo     = p_id_grupo_orig
        AND    id_membresia = r.id_membresia
        AND    fecha_fin    IS NULL;

        -- Insertar en grupo nuevo
        INSERT INTO ACJJ_GRUPOS_LECTORES
            (id_lector, fecha_inicio, id_grupo, id_club, id_membresia)
        VALUES
            (r.id_lector, SYSDATE, v_nuevo_grupo, p_id_club, r.id_membresia);

        v_mitad := v_mitad - 1;
    END LOOP;

    p_id_grupo_nuevo := v_nuevo_grupo;
    p_mensaje        := 'OK: Grupo ' || p_id_grupo_orig ||
                        ' dividido. Nuevo grupo: ' || v_nuevo_grupo ||
                        ' en club ' || p_id_club || '.';
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        p_mensaje := 'ERROR: Grupo ' || p_id_grupo_orig ||
                     ' no encontrado en club ' || p_id_club || '.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_DIVIDIR_GRUPO: ' || SQLERRM;
END ACJJ_SP_DIVIDIR_GRUPO;
/

-- ============================================================
-- [JOSE - SP3] Registrar retiro de miembro
-- Tabla principal: ACJJ_MEMBRESIAS
-- Regla: TRG-05 genera cobro extra si avisa tarde (automatico)
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_RETIRAR_MIEMBRO (
    p_id_lector    IN  ACJJ_LECTORES.id_lector%TYPE,
    p_id_club      IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_membresia IN  ACJJ_MEMBRESIAS.id_membresia%TYPE,
    p_motivo       IN  ACJJ_MEMBRESIAS.motivo_retiro%TYPE,
    p_mensaje      OUT VARCHAR2
) AS
    v_estatus   VARCHAR2(1);
BEGIN
    -- Verificar que la membresia existe y esta activa
    SELECT estatus INTO v_estatus
    FROM   ACJJ_MEMBRESIAS
    WHERE  id_lector    = p_id_lector
    AND    id_club      = p_id_club
    AND    id_membresia = p_id_membresia;

    IF v_estatus != 'A' THEN
        p_mensaje := 'ERROR: La membresia ' || p_id_membresia ||
                     ' del lector ' || p_id_lector || ' ya esta inactiva.';
        RETURN;
    END IF;

    -- Actualizar membresia (TRG-05 evalua cobro extra automaticamente)
    UPDATE ACJJ_MEMBRESIAS
    SET    estatus       = 'I',
           fecha_retiro  = SYSDATE,
           motivo_retiro = p_motivo
    WHERE  id_lector    = p_id_lector
    AND    id_club      = p_id_club
    AND    id_membresia = p_id_membresia;

    -- Cerrar participacion en el grupo
    UPDATE ACJJ_GRUPOS_LECTORES
    SET    fecha_fin = SYSDATE
    WHERE  id_lector    = p_id_lector
    AND    id_club      = p_id_club
    AND    id_membresia = p_id_membresia
    AND    fecha_fin    IS NULL;

    p_mensaje := 'OK: Lector ' || p_id_lector ||
                 ' retirado del club ' || p_id_club || '. ' ||
                 'Motivo: ' || p_motivo;
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        p_mensaje := 'ERROR: No se encontro membresia activa para lector ' ||
                     p_id_lector || ' en club ' || p_id_club || '.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_RETIRAR_MIEMBRO: ' || SQLERRM;
END ACJJ_SP_RETIRAR_MIEMBRO;
/

-- ============================================================
-- [JOSE - SP4] Registrar pago de membresia
-- Tabla principal: ACJJ_PAGOS
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_REGISTRAR_PAGO (
    p_id_lector    IN  ACJJ_LECTORES.id_lector%TYPE,
    p_id_club      IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_membresia IN  ACJJ_MEMBRESIAS.id_membresia%TYPE,
    p_monto        IN  ACJJ_PAGOS.monto%TYPE,
    p_mensaje      OUT VARCHAR2
) AS
    v_tiene_membresia VARCHAR2(1);
    v_estatus         VARCHAR2(1);
    v_nuevo_id_pago   NUMBER;
BEGIN
    -- Verificar que el club cobra membresia
    SELECT tiene_membresia INTO v_tiene_membresia
    FROM   ACJJ_CLUBES_DE_LECTURA
    WHERE  id_club = p_id_club;

    IF v_tiene_membresia != 'S' THEN
        p_mensaje := 'ERROR: El club ' || p_id_club ||
                     ' no maneja pagos de membresia.';
        RETURN;
    END IF;

    -- Verificar que la membresia existe
    SELECT estatus INTO v_estatus
    FROM   ACJJ_MEMBRESIAS
    WHERE  id_lector    = p_id_lector
    AND    id_club      = p_id_club
    AND    id_membresia = p_id_membresia;

    -- Calcular siguiente id_pago
    SELECT NVL(MAX(id_pago), 0) + 1
    INTO   v_nuevo_id_pago
    FROM   ACJJ_PAGOS
    WHERE  id_lector    = p_id_lector
    AND    id_club      = p_id_club
    AND    id_membresia = p_id_membresia;

    -- Registrar el pago
    INSERT INTO ACJJ_PAGOS
        (id_lector, id_club, id_membresia, id_pago, fecha_pago, monto)
    VALUES
        (p_id_lector, p_id_club, p_id_membresia,
         v_nuevo_id_pago, SYSDATE, p_monto);

    p_mensaje := 'OK: Pago ' || v_nuevo_id_pago ||
                 ' registrado para lector ' || p_id_lector ||
                 ' en club ' || p_id_club ||
                 '. Monto: ' || p_monto || '.';
    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        p_mensaje := 'ERROR: Club o membresia no encontrada.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_REGISTRAR_PAGO: ' || SQLERRM;
END ACJJ_SP_REGISTRAR_PAGO;
/

-- ============================================================
-- [JAVIER - SP5] Generar calendario mensual de reuniones
-- Tabla principal: ACJJ_CALENDARIOS_MES
-- Regla: una reunion por semana segun dia_reunion del grupo
--        el libro debe estar definido antes de generar
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_GENERAR_CALENDARIO (
    p_id_club   IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_grupo  IN  ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_isbn      IN  ACJJ_LIBROS.isbn%TYPE,
    p_mes       IN  NUMBER,
    p_anio      IN  NUMBER,
    p_mod_id_lector   IN  ACJJ_LECTORES.id_lector%TYPE,
    p_mod_fecha_inicio IN ACJJ_GRUPOS_LECTORES.fecha_inicio%TYPE,
    p_mod_id_grupo    IN  ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_mod_id_membresia IN ACJJ_MEMBRESIAS.id_membresia%TYPE,
    p_reuniones_generadas OUT NUMBER,
    p_mensaje   OUT VARCHAR2
) AS
    v_dia_reunion  DATE;
    v_fecha_actual DATE;
    v_fecha_fin    DATE;
    v_dia_semana   NUMBER;
    v_contador     NUMBER := 0;
    v_existe_libro NUMBER;
    v_existe_grupo NUMBER;
BEGIN
    -- Validar que el grupo existe
    SELECT COUNT(*) INTO v_existe_grupo
    FROM   ACJJ_GRUPOS_DE_LECTURA
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo;

    IF v_existe_grupo = 0 THEN
        p_mensaje := 'ERROR: Grupo ' || p_id_grupo ||
                     ' no encontrado en club ' || p_id_club || '.';
        RETURN;
    END IF;

    -- Validar que el libro existe
    SELECT COUNT(*) INTO v_existe_libro
    FROM   ACJJ_LIBROS
    WHERE  isbn = p_isbn;

    IF v_existe_libro = 0 THEN
        p_mensaje := 'ERROR: Libro con ISBN ' || p_isbn || ' no existe.';
        RETURN;
    END IF;

    -- Verificar que no haya discusion activa en el grupo
    SELECT COUNT(*) INTO v_contador
    FROM   ACJJ_CALENDARIOS_MES
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo
    AND    (ult_reunion IS NULL OR ult_reunion = 'N');

    IF v_contador > 0 THEN
        p_mensaje := 'ERROR: El grupo ' || p_id_grupo ||
                     ' tiene una discusion activa. ' ||
                     'Cierre la discusion actual antes de generar nuevo calendario.';
        RETURN;
    END IF;

    -- Obtener dia de reunion del grupo
    SELECT dia_reunion INTO v_dia_reunion
    FROM   ACJJ_GRUPOS_DE_LECTURA
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo;

    v_dia_semana   := TO_NUMBER(TO_CHAR(v_dia_reunion, 'D'));
    v_fecha_actual := TO_DATE('01/' || LPAD(p_mes,2,'0') ||
                              '/' || p_anio, 'DD/MM/YYYY');
    v_fecha_fin    := LAST_DAY(v_fecha_actual);

    -- Avanzar hasta el primer dia de reunion del mes
    WHILE TO_NUMBER(TO_CHAR(v_fecha_actual, 'D')) != v_dia_semana LOOP
        v_fecha_actual := v_fecha_actual + 1;
    END LOOP;

    v_contador := 0;

    -- Generar maximo 3 reuniones en el mes (regla del enunciado)
    WHILE v_fecha_actual <= v_fecha_fin AND v_contador < 3 LOOP
        INSERT INTO ACJJ_CALENDARIOS_MES
            (id_club, id_grupo, fecha, isbn_libro, realizado,
             mod_id_lector, mod_fecha_inicio, mod_id_grupo,
             mod_id_club, mod_id_membresia)
        VALUES
            (p_id_club, p_id_grupo, v_fecha_actual, p_isbn, 'N',
             p_mod_id_lector, p_mod_fecha_inicio, p_mod_id_grupo,
             p_id_club, p_mod_id_membresia);

        v_contador     := v_contador + 1;
        v_fecha_actual := v_fecha_actual + 7;
    END LOOP;

    p_reuniones_generadas := v_contador;
    p_mensaje := 'OK: ' || v_contador || ' reuniones generadas para grupo ' ||
                 p_id_grupo || ' del club ' || p_id_club ||
                 ' en ' || LPAD(p_mes,2,'0') || '/' || p_anio || '.';
    COMMIT;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        p_mensaje := 'ERROR: Ya existe una reunion registrada en esa fecha para el grupo.';
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_GENERAR_CALENDARIO: ' || SQLERRM;
END ACJJ_SP_GENERAR_CALENDARIO;
/

-- ============================================================
-- [JAVIER - SP6] Registrar asistencia / inasistencia
-- Tabla principal: ACJJ_INASISTENCIAS
-- Regla: TRG-10 evalua expulsion automaticamente al insertar
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_REGISTRAR_INASISTENCIA (
    p_id_lector    IN  ACJJ_LECTORES.id_lector%TYPE,
    p_id_club      IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_grupo     IN  ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_cal_fecha    IN  ACJJ_CALENDARIOS_MES.fecha%TYPE,
    p_id_membresia IN  ACJJ_MEMBRESIAS.id_membresia%TYPE,
    p_fecha_ini_gl IN  ACJJ_GRUPOS_LECTORES.fecha_inicio%TYPE,
    p_mensaje      OUT VARCHAR2
) AS
    v_existe_reunion NUMBER;
    v_ya_registrada  NUMBER;
    v_en_grupo       NUMBER;
BEGIN
    -- Validar que la reunion existe y fue realizada
    SELECT COUNT(*) INTO v_existe_reunion
    FROM   ACJJ_CALENDARIOS_MES
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo
    AND    fecha    = p_cal_fecha
    AND    realizado = 'S';

    IF v_existe_reunion = 0 THEN
        p_mensaje := 'ERROR: La reunion del ' ||
                     TO_CHAR(p_cal_fecha,'DD/MM/YYYY') ||
                     ' no existe o no ha sido marcada como realizada.';
        RETURN;
    END IF;

    -- Validar que el lector pertenece al grupo
    SELECT COUNT(*) INTO v_en_grupo
    FROM   ACJJ_GRUPOS_LECTORES
    WHERE  id_lector    = p_id_lector
    AND    id_club      = p_id_club
    AND    id_grupo     = p_id_grupo
    AND    id_membresia = p_id_membresia
    AND    fecha_inicio = p_fecha_ini_gl
    AND    fecha_fin    IS NULL;

    IF v_en_grupo = 0 THEN
        p_mensaje := 'ERROR: El lector ' || p_id_lector ||
                     ' no esta activo en el grupo ' || p_id_grupo ||
                     ' del club ' || p_id_club || '.';
        RETURN;
    END IF;

    -- Validar que no este ya registrada la inasistencia
    SELECT COUNT(*) INTO v_ya_registrada
    FROM   ACJJ_INASISTENCIAS
    WHERE  id_lector    = p_id_lector
    AND    id_club      = p_id_club
    AND    id_grupo     = p_id_grupo
    AND    cal_fecha    = p_cal_fecha
    AND    id_membresia = p_id_membresia;

    IF v_ya_registrada > 0 THEN
        p_mensaje := 'ERROR: La inasistencia del lector ' || p_id_lector ||
                     ' para el ' || TO_CHAR(p_cal_fecha,'DD/MM/YYYY') ||
                     ' ya fue registrada.';
        RETURN;
    END IF;

    -- Registrar inasistencia (TRG-10 evalua expulsion automaticamente)
    INSERT INTO ACJJ_INASISTENCIAS
        (id_lector, id_club, id_grupo, cal_fecha, id_membresia, fecha_ini_gl)
    VALUES
        (p_id_lector, p_id_club, p_id_grupo, p_cal_fecha,
         p_id_membresia, p_fecha_ini_gl);

    p_mensaje := 'OK: Inasistencia registrada para lector ' || p_id_lector ||
                 ' en reunion del ' || TO_CHAR(p_cal_fecha,'DD/MM/YYYY') || '.';
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_REGISTRAR_INASISTENCIA: ' || SQLERRM;
END ACJJ_SP_REGISTRAR_INASISTENCIA;
/

-- ============================================================
-- [JAVIER - SP7] Marcar reunion como realizada
-- Tabla principal: ACJJ_CALENDARIOS_MES
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_REALIZAR_REUNION (
    p_id_club   IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_grupo  IN  ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_fecha     IN  ACJJ_CALENDARIOS_MES.fecha%TYPE,
    p_mensaje   OUT VARCHAR2
) AS
    v_existe NUMBER;
    v_ya_realizada VARCHAR2(1);
BEGIN
    SELECT COUNT(*), MAX(realizado)
    INTO   v_existe, v_ya_realizada
    FROM   ACJJ_CALENDARIOS_MES
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo
    AND    fecha    = p_fecha;

    IF v_existe = 0 THEN
        p_mensaje := 'ERROR: No existe reunion para grupo ' || p_id_grupo ||
                     ' del club ' || p_id_club ||
                     ' en fecha ' || TO_CHAR(p_fecha,'DD/MM/YYYY') || '.';
        RETURN;
    END IF;

    IF v_ya_realizada = 'S' THEN
        p_mensaje := 'ERROR: La reunion del ' ||
                     TO_CHAR(p_fecha,'DD/MM/YYYY') ||
                     ' ya fue marcada como realizada.';
        RETURN;
    END IF;

    UPDATE ACJJ_CALENDARIOS_MES
    SET    realizado = 'S'
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo
    AND    fecha    = p_fecha;

    p_mensaje := 'OK: Reunion del ' || TO_CHAR(p_fecha,'DD/MM/YYYY') ||
                 ' marcada como realizada para grupo ' || p_id_grupo ||
                 ' del club ' || p_id_club || '.';
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_REALIZAR_REUNION: ' || SQLERRM;
END ACJJ_SP_REALIZAR_REUNION;
/

-- ============================================================
-- [JAVIER - SP8] Cerrar discusion y registrar valoracion del libro
-- Tabla principal: ACJJ_CALENDARIOS_MES
-- Regla: solo en la ultima reunion (ult_reunion='S')
--        conclusiones y valoracion (1-5) obligatorias
-- ============================================================
CREATE OR REPLACE PROCEDURE ACJJ_SP_CERRAR_DISCUSION (
    p_id_club      IN  ACJJ_CLUBES_DE_LECTURA.id_club%TYPE,
    p_id_grupo     IN  ACJJ_GRUPOS_DE_LECTURA.id_grupo%TYPE,
    p_fecha        IN  ACJJ_CALENDARIOS_MES.fecha%TYPE,
    p_conclusiones IN  ACJJ_CALENDARIOS_MES.conclusiones%TYPE,
    p_valoracion   IN  ACJJ_CALENDARIOS_MES.valoracion%TYPE,
    p_mensaje      OUT VARCHAR2
) AS
    v_existe       NUMBER;
    v_realizado    VARCHAR2(1);
    v_ult_reunion  VARCHAR2(1);
BEGIN
    -- Validar valoracion entre 1 y 5
    IF p_valoracion NOT IN (1,2,3,4,5) THEN
        p_mensaje := 'ERROR: La valoracion debe ser un valor entre 1 y 5.';
        RETURN;
    END IF;

    -- Validar que conclusiones no este vacia
    IF p_conclusiones IS NULL OR TRIM(p_conclusiones) IS NULL THEN
        p_mensaje := 'ERROR: Las conclusiones no pueden estar vacias.';
        RETURN;
    END IF;

    -- Verificar que la reunion existe y fue realizada
    SELECT COUNT(*), MAX(realizado), MAX(ult_reunion)
    INTO   v_existe, v_realizado, v_ult_reunion
    FROM   ACJJ_CALENDARIOS_MES
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo
    AND    fecha    = p_fecha;

    IF v_existe = 0 THEN
        p_mensaje := 'ERROR: Reunion no encontrada para grupo ' || p_id_grupo ||
                     ' del club ' || p_id_club ||
                     ' en fecha ' || TO_CHAR(p_fecha,'DD/MM/YYYY') || '.';
        RETURN;
    END IF;

    IF v_realizado != 'S' THEN
        p_mensaje := 'ERROR: La reunion del ' ||
                     TO_CHAR(p_fecha,'DD/MM/YYYY') ||
                     ' aun no ha sido realizada.';
        RETURN;
    END IF;

    IF v_ult_reunion = 'S' THEN
        p_mensaje := 'ERROR: La discusion de esta reunion ya fue cerrada.';
        RETURN;
    END IF;

    -- Cerrar la discusion en la ultima reunion
    UPDATE ACJJ_CALENDARIOS_MES
    SET    ult_reunion  = 'S',
           conclusiones = p_conclusiones,
           valoracion   = p_valoracion
    WHERE  id_club  = p_id_club
    AND    id_grupo = p_id_grupo
    AND    fecha    = p_fecha;

    -- Marcar las reuniones anteriores del mismo libro como 'N'
    UPDATE ACJJ_CALENDARIOS_MES
    SET    ult_reunion = 'N'
    WHERE  id_club    = p_id_club
    AND    id_grupo   = p_id_grupo
    AND    fecha      < p_fecha
    AND    isbn_libro = (SELECT isbn_libro FROM ACJJ_CALENDARIOS_MES
                         WHERE id_club  = p_id_club
                         AND   id_grupo = p_id_grupo
                         AND   fecha    = p_fecha)
    AND    ult_reunion IS NULL;

    p_mensaje := 'OK: Discusion cerrada para grupo ' || p_id_grupo ||
                 ' del club ' || p_id_club ||
                 '. Valoracion final: ' || p_valoracion || '/5.';
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'ERROR inesperado en SP_CERRAR_DISCUSION: ' || SQLERRM;
END ACJJ_SP_CERRAR_DISCUSION;
/

COMMIT;
-- FIN PROCEDIMIENTOS_GRUPO7_V1.SQL
-- Jose: SP1-SP4 | Javier: SP5-SP8