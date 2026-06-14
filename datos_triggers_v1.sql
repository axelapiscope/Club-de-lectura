-- ============================================================
-- DATOSPARATRIGGERSV1.SQL
-- Proyecto Clubes de Lectura - Grupo 7 ACJJ
-- NRC 25758 - Prof. Lucia Cardoso - 2026
-- Script de pruebas para los 13 triggers de negocio
-- Cada bloque es independiente - usar ROLLBACK entre pruebas
-- Ejecutar con F5 en SQL Developer
-- ============================================================

-- ============================================================
-- TRG-01: Validar edad vs tipo de grupo
-- ============================================================

-- [NEGATIVO-A] Lector adulto (Laura, id=9, nac 1990 → 35 años)
-- intentando entrar al grupo INFANTIL (grupo 1, club 1)
-- DEBE lanzar: TRG-01 ERROR ... Grupo infantil requiere 6-12 anos
INSERT INTO ACJJ_GRUPOS_LECTORES 
    (id_lector, fecha_inicio, id_grupo, id_club, id_membresia)
VALUES (9, SYSDATE, 1, 1, 9);
ROLLBACK;

-- [NEGATIVO-B] Lector infantil (Sofia, id=1, nac 2015 → 11 años)
-- intentando entrar al grupo ADULTO (grupo 3, club 1)
-- DEBE lanzar: TRG-01 ERROR ... Grupo adulto requiere mas de 25 anos
INSERT INTO ACJJ_GRUPOS_LECTORES 
    (id_lector, fecha_inicio, id_grupo, id_club, id_membresia)
VALUES (1, SYSDATE, 3, 1, 1);
ROLLBACK;

-- [POSITIVO] Lector infantil (Diego, id=4, ~10 años) 
-- en grupo INFANTIL de Club 2 (grupo 2, club 2 = tipo 'I')
-- DEBE insertar sin error
INSERT INTO ACJJ_GRUPOS_LECTORES 
    (id_lector, fecha_inicio, id_grupo, id_club, id_membresia)
VALUES (4, SYSDATE, 2, 2, 4);
ROLLBACK;

-- ============================================================
-- TRG-02: Verificar deudas en clubes anteriores
-- ============================================================

-- CONTEXTO: todos los lectores del 1-96 tienen 1 pago hecho
-- Para probar el NEGATIVO necesitamos simular deuda: 
-- insertamos una membresia vieja sin suficientes pagos

-- [NEGATIVO] Primero simulamos que el lector 9 tuvo membresía 
-- en club 1 hace 2 años con solo 1 pago (debería tener 2)
-- Luego intentamos meterlo en club 2
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus, fecha_retiro)
VALUES (9, 1, 999, TO_DATE('01/01/2024','DD/MM/YYYY'), 'I', 
        TO_DATE('01/01/2026','DD/MM/YYYY'));
-- Solo 1 pago cuando debería tener 2 (24 meses / 12 = 2 pagos)
INSERT INTO ACJJ_PAGOS (id_lector, id_club, id_membresia, id_pago, fecha_pago)
VALUES (9, 1, 999, 1, TO_DATE('01/01/2024','DD/MM/YYYY'));

-- Ahora intentamos inscribirlo en club 2 → DEBE fallar
-- DEBE lanzar: TRG-02 ERROR ... tiene pagos pendientes
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 2, 998, SYSDATE, 'A');
ROLLBACK;

-- [POSITIVO] Lector con todos sus pagos al día
-- Lector 9 con membresía de solo 6 meses y 1 pago (CEIL(6/12)=1 → OK)
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus, fecha_retiro)
VALUES (9, 1, 997, TO_DATE('01/01/2026','DD/MM/YYYY'), 'I', 
        TO_DATE('01/06/2026','DD/MM/YYYY'));
INSERT INTO ACJJ_PAGOS (id_lector, id_club, id_membresia, id_pago, fecha_pago)
VALUES (9, 1, 997, 1, TO_DATE('01/01/2026','DD/MM/YYYY'));

-- Ahora sí puede entrar al club 2 → DEBE insertar sin error
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 2, 996, SYSDATE, 'A');
ROLLBACK;

-- ============================================================
-- TRG-03: Auto-crear primer pago al inscribirse
-- ============================================================

-- [POSITIVO-A] Club 1 tiene_membresia='S' 
-- Al insertar la membresía debe crearse un pago automáticamente
-- Usamos un id_membresia libre (997)
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 2, 997, SYSDATE, 'A');

-- Verificar que TRG-03 creó el pago:
SELECT id_lector, id_club, id_membresia, id_pago, fecha_pago 
FROM ACJJ_PAGOS 
WHERE id_lector = 9 AND id_club = 2 AND id_membresia = 997;
-- DEBE devolver 1 fila con fecha_pago = hoy
ROLLBACK;

-- [POSITIVO-B] Verificar que NO crea pago en club sin membresía
-- Primero actualizar un club a tiene_membresia='N' para la prueba
-- (Club 3 no existe en tus datos, usamos enfoque distinto)
-- Verificamos que el contador de pagos no aumenta
-- para un club que tenga_membresia='N' si lo hubiera

-- ============================================================
-- TRG-04: Bloquear ingreso si hay libro en discusión activa
-- ============================================================

-- CONTEXTO: el grupo 3 del club 1 tiene una reunión en CALENDARIOS_MES
-- con ult_reunion IS NULL (discusión activa)
-- Verificamos primero:
SELECT id_club, id_grupo, fecha, isbn_libro, ult_reunion 
FROM ACJJ_CALENDARIOS_MES 
WHERE id_club = 1 AND id_grupo = 3;

-- [NEGATIVO] Intentar meter un lector nuevo en grupo 3 club 1
-- mientras haya discusión activa (ult_reunion IS NULL o 'N')
-- DEBE lanzar: TRG-04 ERROR ... Hay un libro en discusion activa
INSERT INTO ACJJ_GRUPOS_LECTORES 
    (id_lector, fecha_inicio, id_grupo, id_club, id_membresia)
VALUES (36, SYSDATE, 3, 1, 36);
ROLLBACK;

-- [POSITIVO] Meter lector en grupo 3 club 8 (sin discusión activa)
-- Verificamos primero que no tenga discusión:
SELECT COUNT(*) FROM ACJJ_CALENDARIOS_MES 
WHERE id_club = 8 AND id_grupo = 1 
AND (ult_reunion IS NULL OR ult_reunion = 'N');
-- Si devuelve 0, procedemos:
INSERT INTO ACJJ_GRUPOS_LECTORES 
    (id_lector, fecha_inicio, id_grupo, id_club, id_membresia)
VALUES (36, SYSDATE, 1, 8, 36);
ROLLBACK;

-- ============================================================
-- TRG-05: Cobro extra si retiro sin 1 mes de aviso
-- ============================================================

-- [NEGATIVO] Retirar a lector 9 del club 1 HOY
-- Su membresía inició 15/01/2026, aniversario = 15/01/2027
-- Faltan más de 30 días → NO debe generar cobro extra
UPDATE ACJJ_MEMBRESIAS
SET estatus = 'I', 
    fecha_retiro = SYSDATE,
    motivo_retiro = 'Retiro voluntario prueba'
WHERE id_lector = 9 AND id_club = 1 AND id_membresia = 9;

SELECT id_pago, fecha_pago FROM ACJJ_PAGOS
WHERE id_lector = 9 AND id_club = 1 AND id_membresia = 9
ORDER BY id_pago;
-- DEBE tener solo 1 pago (el original) → sin cobro extra
ROLLBACK;

-- [NEGATIVO-B] Simular retiro con menos de 30 días del aniversario
-- Creamos membresía con fecha de ingreso hace casi 1 año
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 2, 990, TO_DATE('20/06/2025','DD/MM/YYYY'), 'A');
INSERT INTO ACJJ_PAGOS (id_lector, id_club, id_membresia, id_pago, fecha_pago)
VALUES (9, 2, 990, 1, TO_DATE('20/06/2025','DD/MM/YYYY'));

-- Retiro HOY (13/06/2026) → aniversario 20/06/2026 → solo 7 días
-- DEBE generar pago extra automáticamente
UPDATE ACJJ_MEMBRESIAS
SET estatus = 'I',
    fecha_retiro = SYSDATE,
    motivo_retiro = 'Retiro con poco aviso - prueba'
WHERE id_lector = 9 AND id_club = 2 AND id_membresia = 990;

SELECT id_pago, fecha_pago FROM ACJJ_PAGOS
WHERE id_lector = 9 AND id_club = 2 AND id_membresia = 990
ORDER BY id_pago;
-- DEBE tener 2 pagos: el original + el extra por retiro tardío
ROLLBACK;

-- ============================================================
-- TRG-06: Límite de capacidad del grupo
-- ============================================================

-- CONTEXTO: Grupo 1 (Infantil) Club 1 tiene 4 lectores (1,2,3,4)
-- Límite I/J = 15, así que todavía entra
-- Para probar el negativo simulamos un grupo lleno

-- [NEGATIVO] Necesitamos un grupo con 15 miembros activos
-- Usamos el grupo 3 club 4 (tipo A, límite 30) - tiene 4 miembros
-- Para un INFANTIL el límite es 15 - usemos grupo 1 club 1 con inserts extra
-- Verificar cuántos hay ahora:
SELECT COUNT(*) FROM ACJJ_GRUPOS_LECTORES 
WHERE id_grupo = 1 AND id_club = 1 AND fecha_fin IS NULL;
-- Tiene 4. Para probar límite rápido, usemos un grupo juvenil 
-- y verifiquemos el mensaje cuando lleguemos a 15

-- [POSITIVO] Grupo 1 Club 1 tiene 4/15 → entra sin problema
-- (ya está probado con los inserts originales)

-- Prueba directa del mensaje: forzamos el límite en un grupo pequeño
-- creando un grupo de prueba temporal con tipo I
-- Primero verificamos el conteo actual del grupo 2 club 4 (tipo I):
SELECT COUNT(*) FROM ACJJ_GRUPOS_LECTORES 
WHERE id_grupo = 2 AND id_club = 4 AND fecha_fin IS NULL;
-- Si ya tiene 15, cualquier insert nuevo debe fallar con TRG-06

-- ============================================================
-- TRG-07: Horario entre 17:00 y antes de 19:00, Lun-Vie
-- ============================================================

-- [NEGATIVO-A] Hora demasiado temprana (10:00 am)
-- DEBE lanzar: TRG-07 ERROR ... no puede empezar antes de las 17:00
INSERT INTO ACJJ_GRUPOS_DE_LECTURA 
    (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
VALUES (1, 99, 'A', SYSDATE,
        TO_DATE('15/06/2026','DD/MM/YYYY'),      -- lunes
        TO_DATE('01/01/2026 10:00','DD/MM/YYYY HH24:MI'));
ROLLBACK;

-- [NEGATIVO-B] Hora en fin de semana (domingo)
-- DEBE lanzar: TRG-07 ERROR ... solo pueden ser de lunes a viernes
INSERT INTO ACJJ_GRUPOS_DE_LECTURA 
    (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
VALUES (1, 99, 'A', SYSDATE,
        TO_DATE('14/06/2026','DD/MM/YYYY'),      -- domingo
        TO_DATE('01/01/2026 17:00','DD/MM/YYYY HH24:MI'));
ROLLBACK;

-- [NEGATIVO-C] Hora exactamente 19:00 (fuera de rango)
-- DEBE lanzar: TRG-07 ERROR ... no puede empezar a las 19:00 o despues
INSERT INTO ACJJ_GRUPOS_DE_LECTURA 
    (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
VALUES (1, 99, 'A', SYSDATE,
        TO_DATE('16/06/2026','DD/MM/YYYY'),      -- lunes
        TO_DATE('01/01/2026 19:00','DD/MM/YYYY HH24:MI'));
ROLLBACK;

-- [POSITIVO] Lunes a las 18:00 → válido
-- DEBE insertar sin error
INSERT INTO ACJJ_GRUPOS_DE_LECTURA 
    (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
VALUES (1, 99, 'A', SYSDATE,
        TO_DATE('16/06/2026','DD/MM/YYYY'),      -- lunes
        TO_DATE('01/01/2026 18:00','DD/MM/YYYY HH24:MI'));
ROLLBACK;

-- ============================================================
-- TRG-08: Grupos infantiles deben iniciar máximo a las 17:00
-- ============================================================

-- [NEGATIVO] Grupo infantil con hora 18:00
-- DEBE lanzar: TRG-08 ERROR ... grupos infantiles deben iniciar a las 17:00 como maximo
INSERT INTO ACJJ_GRUPOS_DE_LECTURA 
    (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
VALUES (1, 99, 'I', SYSDATE,
        TO_DATE('16/06/2026','DD/MM/YYYY'),      -- lunes
        TO_DATE('01/01/2026 18:00','DD/MM/YYYY HH24:MI'));
ROLLBACK;

-- [NEGATIVO-B] Grupo infantil con hora 17:30
-- DEBE lanzar también TRG-08 (17.5 > 17)
INSERT INTO ACJJ_GRUPOS_DE_LECTURA 
    (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
VALUES (1, 99, 'I', SYSDATE,
        TO_DATE('16/06/2026','DD/MM/YYYY'),
        TO_DATE('01/01/2026 17:30','DD/MM/YYYY HH24:MI'));
ROLLBACK;

-- [POSITIVO] Grupo infantil con hora exacta 17:00 → válido
-- DEBE insertar sin error
INSERT INTO ACJJ_GRUPOS_DE_LECTURA 
    (id_club, id_grupo, tipo, fecha_creacion, dia_reunion, hora_ini_reu)
VALUES (1, 99, 'I', SYSDATE,
        TO_DATE('16/06/2026','DD/MM/YYYY'),
        TO_DATE('01/01/2026 17:00','DD/MM/YYYY HH24:MI'));
ROLLBACK;

-- ============================================================
-- TRG-09: Moderador debe pertenecer al grupo correcto
-- ============================================================

-- CONTEXTO: Grupo 1 (Infantil, club 1) → moderador debe ser del grupo ADULTO del club 1
-- Lectores adultos en club 1: 9,10,11,12 (grupo 3, club 1)
-- Lector 9 (Laura) → adulta, grupo 3, club 1 → VÁLIDA como moderadora de infantil

-- [NEGATIVO] Usar como moderador a lector 1 (Sofia, infantil)
-- para el grupo 1 (infantil) del club 1
-- Sofia no es adulta → DEBE lanzar TRG-09 ERROR
INSERT INTO ACJJ_CALENDARIOS_MES 
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia)
VALUES (1, 1, TO_DATE('20/06/2026','DD/MM/YYYY'), 9788490638743, 'N',
        1,                                    -- moderador: Sofia (infantil) ← INVÁLIDO
        TO_DATE('15/01/2026','DD/MM/YYYY'), 1, 1, 1);
ROLLBACK;

-- [NEGATIVO-B] Usar moderador de otro club (lector 13, grupo 1 club 2)
-- para el grupo 3 adulto del club 1
-- DEBE lanzar TRG-09 ERROR: no pertenece al grupo
INSERT INTO ACJJ_CALENDARIOS_MES 
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia)
VALUES (1, 3, TO_DATE('20/06/2026','DD/MM/YYYY'), 9788490638743, 'N',
        13,                                   -- lector 13 es del club 2, no del club 1
        TO_DATE('15/01/2026','DD/MM/YYYY'), 1, 2, 13);
ROLLBACK;

-- [POSITIVO] Laura (id=9) modera el grupo INFANTIL (grupo 1, club 1)
-- Laura es adulta (grupo 3, club 1) → VÁLIDA para moderar infantil
INSERT INTO ACJJ_CALENDARIOS_MES 
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia)
VALUES (1, 1, TO_DATE('20/06/2026','DD/MM/YYYY'), 9788490638743, 'N',
        9,                                    -- Laura: adulta grupo 3, club 1 ← VÁLIDA
        TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 9);
ROLLBACK;

-- [POSITIVO-B] Miguel (id=10) modera el grupo ADULTO (grupo 3, club 1)
-- Miguel pertenece al grupo 3 club 1 → VÁLIDO para moderar su propio grupo
INSERT INTO ACJJ_CALENDARIOS_MES 
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia)
VALUES (1, 3, TO_DATE('21/06/2026','DD/MM/YYYY'), 9788490638743, 'N',
        10,                                   -- Miguel: grupo 3, club 1 ← VÁLIDO
        TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 10);
ROLLBACK;

-- ============================================================
-- TRG-10: Auto-expulsión por más del 30% de inasistencias
-- Tabla: ACJJ_INASISTENCIAS (AFTER INSERT)
-- Casos: NEGATIVO (expulsa) y POSITIVO (no expulsa)
-- ============================================================

-- Verificacion previa: reuniones realizadas en bimestre Mar-Abr 2026
-- para grupo 3, club 1 (donde estan los datos de Carmelo)
SELECT fecha, realizado 
FROM   ACJJ_CALENDARIOS_MES 
WHERE  id_club   = 1 
AND    id_grupo  = 3 
AND    realizado = 'S'
AND    fecha BETWEEN TO_DATE('01/03/2026','DD/MM/YYYY') 
                 AND TO_DATE('30/04/2026','DD/MM/YYYY');
-- DEBE devolver 2 filas: 21/03/2026 y 11/04/2026

-- ------------------------------------------------------------
-- [NEGATIVO] 2 inasistencias / 2 reuniones = 100% → EXPULSA
-- Lector 9 (Laura), grupo 3, club 1, membresia 9
-- ------------------------------------------------------------
INSERT INTO ACJJ_INASISTENCIAS 
    (id_lector, id_club, id_grupo, cal_fecha, id_membresia, fecha_ini_gl)
VALUES (9, 1, 3, TO_DATE('21/03/2026','DD/MM/YYYY'), 9, 
        TO_DATE('15/01/2026','DD/MM/YYYY'));

INSERT INTO ACJJ_INASISTENCIAS 
    (id_lector, id_club, id_grupo, cal_fecha, id_membresia, fecha_ini_gl)
VALUES (9, 1, 3, TO_DATE('11/04/2026','DD/MM/YYYY'), 9, 
        TO_DATE('15/01/2026','DD/MM/YYYY'));

-- Verificar expulsion en membresia
SELECT id_lector, estatus, motivo_retiro 
FROM   ACJJ_MEMBRESIAS 
WHERE  id_lector = 9 AND id_club = 1 AND id_membresia = 9;
-- DEBE mostrar: estatus='I' motivo='Expulsado automaticamente: 100%...'

-- Verificar cierre en grupos
SELECT id_lector, fecha_fin 
FROM   ACJJ_GRUPOS_LECTORES
WHERE  id_lector = 9 AND id_club = 1 AND id_grupo = 3;
-- DEBE mostrar: fecha_fin = hoy

ROLLBACK;

-- ------------------------------------------------------------
-- [POSITIVO] 1 inasistencia / 4 reuniones = 25% → NO EXPULSA
-- Usamos bimestre May-Jun 2026 con fechas nuevas que no existen
-- ------------------------------------------------------------

-- Insertar 4 reuniones realizadas en bimestre May-Jun 2026
INSERT INTO ACJJ_CALENDARIOS_MES
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia,
     ult_reunion, conclusiones, valoracion)
VALUES (1, 3, TO_DATE('02/05/2026','DD/MM/YYYY'), 9788490638743, 'S',
        10, TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 10,
        NULL, NULL, NULL);

INSERT INTO ACJJ_CALENDARIOS_MES
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia,
     ult_reunion, conclusiones, valoracion)
VALUES (1, 3, TO_DATE('09/05/2026','DD/MM/YYYY'), 9788490638743, 'S',
        10, TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 10,
        NULL, NULL, NULL);

INSERT INTO ACJJ_CALENDARIOS_MES
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia,
     ult_reunion, conclusiones, valoracion)
VALUES (1, 3, TO_DATE('16/05/2026','DD/MM/YYYY'), 9788490638743, 'S',
        10, TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 10,
        NULL, NULL, NULL);

INSERT INTO ACJJ_CALENDARIOS_MES
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia,
     ult_reunion, conclusiones, valoracion)
VALUES (1, 3, TO_DATE('23/05/2026','DD/MM/YYYY'), 9788490638743, 'S',
        10, TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 10,
        NULL, NULL, NULL);

-- 1 inasistencia sobre 4 reuniones = 25% → NO debe expulsar
INSERT INTO ACJJ_INASISTENCIAS 
    (id_lector, id_club, id_grupo, cal_fecha, id_membresia, fecha_ini_gl)
VALUES (9, 1, 3, TO_DATE('02/05/2026','DD/MM/YYYY'), 9, 
        TO_DATE('15/01/2026','DD/MM/YYYY'));

-- Verificar que Laura NO fue expulsada
SELECT id_lector, estatus, motivo_retiro 
FROM   ACJJ_MEMBRESIAS 
WHERE  id_lector = 9 AND id_club = 1 AND id_membresia = 9;
-- DEBE mostrar: estatus='A' y motivo_retiro=NULL → sigue activa

ROLLBACK;

-- ============================================================
-- TRG-11: Un solo club activo por lector
-- ============================================================

-- [NEGATIVO] Lector 9 ya tiene membresía activa en club 1
-- Intentar meterlo en club 2 al mismo tiempo
-- DEBE lanzar: TRG-11 ERROR ... ya tiene una membresia activa en otro club
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 2, 990, SYSDATE, 'A');
ROLLBACK;

-- [POSITIVO] Lector 9 con estatus 'I' en club 1 → puede entrar a club 2
UPDATE ACJJ_MEMBRESIAS 
SET estatus='I', fecha_retiro=SYSDATE 
WHERE id_lector=9 AND id_club=1 AND id_membresia=9;

INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 2, 990, SYSDATE, 'A');
-- DEBE insertar sin error
ROLLBACK;

-- ============================================================
-- TRG-12: Moderador en un solo grupo activo a la vez
-- ============================================================

-- CONTEXTO: Laura (id=9) ya está moderando grupo 3 club 1
-- (si hay un CALENDARIOS_MES activo con mod_id_lector=9)

-- [NEGATIVO] Asignar a Laura como moderadora de grupo 2 (juvenil)
-- mientras sigue moderando el grupo 3
-- DEBE lanzar: TRG-12 ERROR ... ya esta moderando otro grupo activo
INSERT INTO ACJJ_CALENDARIOS_MES 
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia)
VALUES (1, 2, TO_DATE('20/06/2026','DD/MM/YYYY'), 9788490638743, 'N',
        9,
        TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 9);
ROLLBACK;

-- [POSITIVO] Usar a Miguel (id=10) que no tiene grupos activos como moderador
INSERT INTO ACJJ_CALENDARIOS_MES 
    (id_club, id_grupo, fecha, isbn_libro, realizado,
     mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia)
VALUES (1, 3, TO_DATE('25/06/2026','DD/MM/YYYY'), 9788490638743, 'N',
        10,
        TO_DATE('15/01/2026','DD/MM/YYYY'), 3, 1, 10);
ROLLBACK;

-- ============================================================
-- TRG-13: Bloquear reingreso tras expulsión
-- ============================================================

-- [NEGATIVO] Simular que lector 9 fue expulsado del club 1
UPDATE ACJJ_MEMBRESIAS
SET estatus = 'I',
    fecha_retiro = SYSDATE,
    motivo_retiro = 'Expulsado automaticamente: 66.7% inasistencias en bimestre 05/2026-06/2026'
WHERE id_lector = 9 AND id_club = 1 AND id_membresia = 9;

-- Intentar reingresar al mismo club
-- DEBE lanzar: TRG-13 ERROR ... fue expulsado del club ... y no puede volver
INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 1, 990, SYSDATE, 'A');
ROLLBACK;

-- [POSITIVO] Lector expulsado del club 1 puede entrar al club 2
UPDATE ACJJ_MEMBRESIAS
SET estatus = 'I',
    fecha_retiro = SYSDATE,
    motivo_retiro = 'Expulsado automaticamente: 66.7% inasistencias en bimestre 05/2026-06/2026'
WHERE id_lector = 9 AND id_club = 1 AND id_membresia = 9;

INSERT INTO ACJJ_MEMBRESIAS 
    (id_lector, id_club, id_membresia, fecha_ingreso, estatus)
VALUES (9, 2, 990, SYSDATE, 'A');
-- DEBE insertar sin error (expulsión fue en club 1, no en club 2)
ROLLBACK;