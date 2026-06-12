CREATE OR REPLACE FUNCTION conversion_monetaria (
    p_precio IN NUMBER,
    p_tasa   IN NUMBER
) RETURN VARCHAR2 IS
    v_resultado NUMBER(10,2);
BEGIN
    IF p_tasa IS NULL OR p_tasa <= 0 THEN
        RETURN NULL;
    END IF;

    v_resultado := p_precio / p_tasa;
    RETURN TO_CHAR(v_resultado, '$99999990.99');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR inesperado en conversion_monetaria.');
        RETURN NULL;
END conversion_monetaria;
/
create or replace FUNCTION antiguedad_miembro_club
    (p_id_lector IN NUMBER, p_id_club IN NUMBER)
    RETURN NUMBER IS
        v_fecha_inicio DATE;
        v_fecha_fin DATE;
        v_antiguedad NUMBER;
    BEGIN
        SELECT fecha_ingreso, fecha_retiro
        INTO v_fecha_inicio, v_fecha_fin
        FROM ACJJ_MEMBRESIAS
        WHERE id_lector = p_id_lector AND id_club = p_id_club AND fecha_ingreso = (SELECT MAX(fecha_ingreso) from ACJJ_MEMBRESIAS
                                                                                    WHERE id_lector = p_id_lector AND id_club = p_id_club);

        v_antiguedad := TRUNC(MONTHS_BETWEEN(NVL(v_fecha_fin, SYSDATE), v_fecha_inicio), 0);

        RETURN v_antiguedad;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0; 
    END antiguedad_miembro_club;
--
/
create or replace FUNCTION PROM_PARTICIPACION_MENSUAL_TIPOGRUPO (
    p_id_club    IN NUMBER,
    p_tipo_grupo IN VARCHAR2,
    p_mes_ano    IN DATE
) RETURN NUMBER 
IS
    v_asistencias_posibles NUMBER := 0;
    v_inasistencias        NUMBER := 0;
    v_porcentaje           NUMBER := 0;
BEGIN
    -- 1. ASISTENCIAS POSIBLES usando subconsulta para amarrar el grupo
    SELECT COUNT(*) INTO v_asistencias_posibles
    FROM ACJJ_GRUPOS_LECTORES gl, 
         ACJJ_CALENDARIOS_MES c
    WHERE gl.id_club = c.id_club 
      AND gl.id_grupo = c.id_grupo
      AND gl.id_club = p_id_club
      AND TO_CHAR(c.fecha, 'YYYY-MM') = TO_CHAR(p_mes_ano, 'YYYY-MM')
      AND gl.fecha_inicio <= c.fecha 
      AND (gl.fecha_fin IS NULL OR gl.fecha_fin >= c.fecha)
      AND gl.id_grupo IN (
          SELECT id_grupo 
          FROM ACJJ_GRUPOS_DE_LECTURA 
          WHERE id_club = p_id_club 
            AND tipo = p_tipo_grupo
      );

    -- 2. INASISTENCIAS REALES usando subconsulta
    SELECT COUNT(*) INTO v_inasistencias
    FROM ACJJ_INASISTENCIAS i
    WHERE i.id_club = p_id_club
      AND TO_CHAR(i.cal_fecha, 'YYYY-MM') = TO_CHAR(p_mes_ano, 'YYYY-MM')
      AND i.id_grupo IN (
          SELECT id_grupo 
          FROM ACJJ_GRUPOS_DE_LECTURA 
          WHERE id_club = p_id_club 
            AND tipo = p_tipo_grupo
      );

    -- 3. CÁLCULO
    IF v_asistencias_posibles > 0 THEN
        v_porcentaje := ((v_asistencias_posibles - v_inasistencias) / v_asistencias_posibles) * 100;
    ELSE
        v_porcentaje := 0;
    END IF;

    RETURN ROUND(v_porcentaje, 2);
END PROM_PARTICIPACION_MENSUAL_TIPOGRUPO;
-- 
/
create or replace FUNCTION porc_participacion_bim_miembro
    (p_id_lector NUMBER, p_fecha_inicio DATE) 
    RETURN NUMBER IS 
        v_total_posible          NUMBER := 0; 
        v_total_inasistencias    NUMBER := 0; 
        v_reuniones_grupo        NUMBER := 0; 
        v_inasistencias_grupo    NUMBER := 0; 
        v_porcentaje             NUMBER := 0;
        v_fecha_ini              DATE;
        v_fecha_fin              DATE;

        CURSOR c_grupos_miembro IS 
            SELECT id_grupo, id_club
            FROM ACJJ_GRUPOS_LECTORES 
            WHERE id_lector = p_id_lector
            AND (fecha_fin IS NULL OR fecha_fin >= v_fecha_ini); 
    BEGIN 
        v_fecha_ini := TRUNC(p_fecha_inicio, 'MM');
        v_fecha_fin := ADD_MONTHS(v_fecha_ini, 2) - 1;

        FOR g IN c_grupos_miembro LOOP 

            SELECT COUNT(*) 
            INTO v_reuniones_grupo 
            FROM ACJJ_CALENDARIOS_MES 
            WHERE id_grupo = g.id_grupo
            AND id_club = g.id_club
            AND realizado IS NOT NULL 
            AND realizado <> 'N'
            AND fecha BETWEEN v_fecha_ini AND v_fecha_fin;

            SELECT COUNT(*) 
            INTO v_inasistencias_grupo 
            FROM ACJJ_INASISTENCIAS 
            WHERE id_lector = p_id_lector
            AND id_grupo = g.id_grupo
            AND id_club = g.id_club
            AND cal_fecha BETWEEN v_fecha_ini AND v_fecha_fin;

            v_total_posible       := v_total_posible + v_reuniones_grupo;
            v_total_inasistencias := v_total_inasistencias + v_inasistencias_grupo; 

        END LOOP; 

        IF v_total_posible > 0 THEN
            v_porcentaje := ((v_total_posible - v_total_inasistencias) / v_total_posible) * 100; 
        ELSE
            v_porcentaje := 0;
        END IF;

        RETURN ROUND(v_porcentaje, 2); 
    END porc_participacion_bim_miembro;
--
/
CREATE OR REPLACE FUNCTION edad_miembro
    (p_id_lector NUMBER)
    RETURN NUMBER IS
        v_fecha_nac DATE;
        v_edad number;
    BEGIN
        SELECT fecha_nac 
        INTO v_fecha_nac
        FROM ACJJ_LECTORES
        WHERE id_lector = p_id_lector;

        v_edad := TRUNC(MONTHS_BETWEEN(SYSDATE, v_fecha_nac)/12, 0);

        RETURN(v_edad);

    END edad_miembro;
--