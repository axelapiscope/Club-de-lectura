-- ============================================================
--  0_DROP_TODO.sql  --  "Borrón y Cuenta Nueva"
--  Proyecto: Club de Lectura  |  Esquema: ACJJ_*
--  Generado: 2026-06-12
--  Fuente:   createsv4.sql (versión definitiva del equipo)
--
--  USO: ejecutar completo en SQL Developer como el usuario
--       propietario del esquema.  Orden: tablas hijas primero,
--       padres al final.  CASCADE CONSTRAINTS cubre cualquier FK
--       residual.
-- ============================================================

-- ------------------------------------------------------------
-- SECCIÓN 1: DROP de tablas (hijas → padres)
-- ------------------------------------------------------------

-- Tablas de detalle / cruce (máxima dependencia)
DROP TABLE ACJJ_MEJORES_ACTORES    CASCADE CONSTRAINTS;
DROP TABLE ACJJ_PRESENTACIONES     CASCADE CONSTRAINTS;
DROP TABLE ACJJ_ELENCOS            CASCADE CONSTRAINTS;
DROP TABLE ACJJ_INASISTENCIAS      CASCADE CONSTRAINTS;
DROP TABLE ACJJ_CALENDARIOS_MES    CASCADE CONSTRAINTS;
DROP TABLE ACJJ_GRUPOS_LECTORES    CASCADE CONSTRAINTS;
DROP TABLE ACJJ_PAGOS              CASCADE CONSTRAINTS;
DROP TABLE ACJJ_MEMBRESIAS         CASCADE CONSTRAINTS;
DROP TABLE ACJJ_GRUPOS_DE_LECTURA  CASCADE CONSTRAINTS;
DROP TABLE ACJJ_IDIOM_CLUB_LEC     CASCADE CONSTRAINTS;
DROP TABLE ACJJ_CLUBES_ASOCIADOS   CASCADE CONSTRAINTS;
DROP TABLE ACJJ_CLUBES_DE_LECTURA  CASCADE CONSTRAINTS;
DROP TABLE ACJJ_LIBROS_PREFERIDOS  CASCADE CONSTRAINTS;
DROP TABLE ACJJ_TELEFONOS          CASCADE CONSTRAINTS;
DROP TABLE ACJJ_LIBROS_AUTORES     CASCADE CONSTRAINTS;

-- Tablas intermedias
DROP TABLE ACJJ_OBRAS_TEATRALES    CASCADE CONSTRAINTS;
DROP TABLE ACJJ_LECTORES           CASCADE CONSTRAINTS;
DROP TABLE ACJJ_LIBROS             CASCADE CONSTRAINTS;
DROP TABLE ACJJ_CIUDADES           CASCADE CONSTRAINTS;

-- Tablas maestras / catálogos (mínima dependencia)
DROP TABLE ACJJ_IDIOMAS            CASCADE CONSTRAINTS;
DROP TABLE ACJJ_REPRESENTANTES     CASCADE CONSTRAINTS;
DROP TABLE ACJJ_INSTITUCIONES      CASCADE CONSTRAINTS;
DROP TABLE ACJJ_AUTORES            CASCADE CONSTRAINTS;
DROP TABLE ACJJ_PAISES             CASCADE CONSTRAINTS;

-- ------------------------------------------------------------
-- SECCIÓN 2: DROP de secuencias
-- ------------------------------------------------------------

DROP SEQUENCE ACJJ_PAISES_SEQ;
DROP SEQUENCE ACJJ_AUTORES_SEQ;
DROP SEQUENCE ACJJ_INSTITUCIONES_SEQ;
DROP SEQUENCE ACJJ_REPRESENTANTES_SEQ;
DROP SEQUENCE ACJJ_IDIOMAS_SEQ;
DROP SEQUENCE ACJJ_LECTORES_SEQ;
DROP SEQUENCE ACJJ_TELEFONOS_SEQ;
DROP SEQUENCE ACJJ_CLUBES_SEQ;
DROP SEQUENCE ACJJ_IDIOM_CLUB_LEC_SEQ;

-- ------------------------------------------------------------
-- SECCIÓN 3: Limpiar la papelera del esquema
-- ------------------------------------------------------------

PURGE RECYCLEBIN;

-- ============================================================
--  FIN DEL SCRIPT  --  El esquema queda en blanco.
-- ============================================================
