--------------------------------------------------------
-- SCRIPT COMPLETO DE CREATES
-- UCAB, Sistemas de Bases de Datos, Prof: L. Cardoso 
-- Grupo 7:  Axel Apiscope CI: 30.136.574, Javier Bonilla CI: 30.513.404, Carmelo Moschella: CI: 30.861.195 y Jose Perdomo CI: 31.382.767
-- Proyecto Clubes de Lectura
--------------------------------------------------------

--
-- CREATES DE LAS TABLAS
--

-- 
-- 1. ACJJ_PAISES
-- 
CREATE TABLE ACJJ_PAISES (
    id_pais      NUMBER(3) NOT NULL,
    nombre_pais  VARCHAR2(15) NOT NULL,
    moneda_local VARCHAR2(3) NOT NULL,
    nacionalidad VARCHAR2(20) NOT NULL,
    CONSTRAINT PAISES_PK PRIMARY KEY (id_pais),
    CONSTRAINT PAIS_UNIQUE UNIQUE (nombre_pais)
);

-- 
-- 2. ACJJ_AUTORES
-- 
CREATE TABLE ACJJ_AUTORES (
    id_autor   NUMBER(4) NOT NULL,
    nombre     VARCHAR2(15),
    apellido   VARCHAR2(15),
    pseudonimo VARCHAR2(15),
    CONSTRAINT AUTORES_PK PRIMARY KEY (id_autor),
    CONSTRAINT CHECK_AL_MENOS_UN_NOMBRE CHECK (nombre IS NOT NULL 
        OR apellido IS NOT NULL OR pseudonimo IS NOT NULL)
);

-- 
-- 3. ACJJ_INSTITUCIONES
-- 
CREATE TABLE ACJJ_INSTITUCIONES (
    id_institucion NUMBER(3) NOT NULL,
    nombre         VARCHAR2(50) NOT NULL,
    tipo           VARCHAR2(11) NOT NULL,
    CONSTRAINT INSTITUCIONES_PK PRIMARY KEY (id_institucion),
    CONSTRAINT CHECK_TIPO_INSTITUCION CHECK (tipo IN ('BIBLIOTECA', 'UNIVERSIDAD', 'COLEGIO', 'OTRO'))
);

-- 
-- 4. ACJJ_REPRESENTANTES
-- 
CREATE TABLE ACJJ_REPRESENTANTES (
    id_rep        NUMBER(3) NOT NULL,
    doc_identidad VARCHAR2(15) NOT NULL,
    p_nombre      VARCHAR2(15) NOT NULL,
    p_apellido    VARCHAR2(15) NOT NULL,
    s_apellido    VARCHAR2(15) NOT NULL,
    email         VARCHAR2(50) NOT NULL,
    s_nombre      VARCHAR2(15),
    CONSTRAINT REPRESENTANTES_PK PRIMARY KEY (id_rep),
    CONSTRAINT REP_EMAIL_UN UNIQUE (email),
    CONSTRAINT REP_DOC_UN UNIQUE (doc_identidad)
);

-- 
-- 5. ACJJ_IDIOMAS
-- 
CREATE TABLE ACJJ_IDIOMAS (
    id_idioma NUMBER(3) NOT NULL,
    nombre    VARCHAR2(15) NOT NULL,
    CONSTRAINT IDIOMAS_PK PRIMARY KEY (id_idioma),
    CONSTRAINT IDIOMA_UNIQUE UNIQUE (nombre)
);

-- 
-- 6. ACJJ_CIUDADES
-- 
CREATE TABLE ACJJ_CIUDADES (
    id_pais       NUMBER(3) NOT NULL,
    id_ciudad     NUMBER(5) NOT NULL,
    nombre_ciudad VARCHAR2(30) NOT NULL,
    CONSTRAINT CIUDADES_PK PRIMARY KEY (id_pais, id_ciudad),
    CONSTRAINT CIUDADES_PAISES_FK FOREIGN KEY (id_pais) 
        REFERENCES ACJJ_PAISES (id_pais)
);

-- 
-- 7. ACJJ_LIBROS
-- 
CREATE TABLE ACJJ_LIBROS (
    isbn              NUMBER(13) NOT NULL,
    titulo            VARCHAR2(100) NOT NULL,
    ano_publicacion   DATE NOT NULL,
    can_paginas       NUMBER(4) NOT NULL,
    sinopsis          VARCHAR2(2000) NOT NULL,
    tipo_narrativa    VARCHAR2(15) NOT NULL,
    temas             VARCHAR2(40) NOT NULL,
    id_pais           NUMBER(3) NOT NULL,
    isbn_lib_anterior NUMBER(13),
    CONSTRAINT LIBROS_PK PRIMARY KEY (isbn),
    CONSTRAINT LIBROS_PAISES_FK FOREIGN KEY (id_pais) 
        REFERENCES ACJJ_PAISES (id_pais),
    CONSTRAINT LIBROS_AN_FK FOREIGN KEY (isbn_lib_anterior) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 
-- 8. ACJJ_LIBROS_AUTORES
-- 
CREATE TABLE ACJJ_LIBROS_AUTORES (
    isbn     NUMBER(13) NOT NULL,
    id_autor NUMBER(4) NOT NULL,
    CONSTRAINT LIBROS_AUTORES_PK PRIMARY KEY (isbn, id_autor),
    CONSTRAINT LIB_AUT_AUTORES_FK FOREIGN KEY (id_autor) 
        REFERENCES ACJJ_AUTORES (id_autor),
    CONSTRAINT LIB_AUT_LIBROS_FK FOREIGN KEY (isbn) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 
-- 9. ACJJ_LECTORES
-- 
CREATE TABLE ACJJ_LECTORES (
    id_lector       NUMBER(4) NOT NULL,
    doc_identidad   VARCHAR2(15) NOT NULL,
    p_nombre        VARCHAR2(15) NOT NULL,
    p_apellido      VARCHAR2(15) NOT NULL,
    s_apellido      VARCHAR2(15) NOT NULL,
    email           VARCHAR2(80) NOT NULL,
    fecha_nac       DATE NOT NULL,
    id_pais         NUMBER(3) NOT NULL,
    id_rep          NUMBER(3),
    id_lector_rep   NUMBER(4),
    s_nombre        VARCHAR2(15),
    CONSTRAINT LECTORES_PK PRIMARY KEY (id_lector),
    CONSTRAINT LEC_DOCID_UNIQUE UNIQUE (doc_identidad),
    CONSTRAINT LEC_EMAIL_UNIQUE UNIQUE (email),
    CONSTRAINT LEC_PAISES_FK FOREIGN KEY (id_pais)
        REFERENCES ACJJ_PAISES (id_pais),
    CONSTRAINT CHECK_ARCO_REP CHECK((id_rep IS NULL AND id_lector_rep IS NOT NULL) 
        OR (id_rep IS NOT NULL AND id_lector_rep IS NULL) OR (id_rep IS NULL AND id_lector_rep IS NULL)),
    CONSTRAINT LEC_REPRESENTANTES_FK FOREIGN KEY (id_rep) 
        REFERENCES ACJJ_REPRESENTANTES (id_rep),
    CONSTRAINT LEC_LECTORES_FK FOREIGN KEY (id_lector_rep) 
        REFERENCES ACJJ_LECTORES (id_lector)
);

-- 
-- 10. ACJJ_TELEFONOS
-- 
CREATE TABLE ACJJ_TELEFONOS (
    id_tel        NUMBER(4) NOT NULL,
    codigo_pais   VARCHAR2(3) NOT NULL,
    codigo_area   VARCHAR2(6) NOT NULL,
    numero        VARCHAR2(20) NOT NULL,
    id_lector     NUMBER(4),
    id_rep        NUMBER(3),
    CONSTRAINT TELEFONOS_PK PRIMARY KEY (id_tel),
    CONSTRAINT TEL_NUMERO_UN UNIQUE (id_tel, codigo_area, numero),
    CONSTRAINT CHECK_ARCO_TEL CHECK (
        ((id_lector IS NOT NULL) AND (id_rep IS NULL)) OR 
        ((id_rep IS NOT NULL) AND (id_lector IS NULL))
    ),
    CONSTRAINT TEL_LECTORES_FK FOREIGN KEY (id_lector) 
        REFERENCES ACJJ_LECTORES (id_lector),
    CONSTRAINT TEL_REPRESENTANTES_FK FOREIGN KEY (id_rep) 
        REFERENCES ACJJ_REPRESENTANTES (id_rep)
);

-- 
-- 11. ACJJ_LIBROS_PREFERIDOS
-- 
CREATE TABLE ACJJ_LIBROS_PREFERIDOS (
    id_lector  NUMBER(4) NOT NULL,
    orden_pref NUMBER(1) NOT NULL,
    isbn       NUMBER(13) NOT NULL,
    CONSTRAINT LIBROS_PREF_PK PRIMARY KEY (id_lector, orden_pref, isbn),
    CONSTRAINT CHECK_ORDEN_PREF CHECK (orden_pref IN (1,2,3)),
    CONSTRAINT LIB_PREF_LECTORES_FK FOREIGN KEY (id_lector) 
        REFERENCES ACJJ_LECTORES (id_lector),
    CONSTRAINT LIB_PREF_LIBROS_FK FOREIGN KEY (isbn) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 
-- 12. ACJJ_CLUBES_DE_LECTURA
-- 
CREATE TABLE ACJJ_CLUBES_DE_LECTURA (
    id_club         NUMBER(3) NOT NULL,
    nombre_club     VARCHAR2(60) NOT NULL,
    email           VARCHAR2(50) NOT NULL,
    direccion       VARCHAR2(50) NOT NULL,
    cod_postal      VARCHAR2(10) NOT NULL,
    id_ciudad       NUMBER(5) NOT NULL,
    id_pais         NUMBER(3) NOT NULL,
    tiene_membresia VARCHAR2(1),
    id_institucion  NUMBER(3),
    CONSTRAINT CLUBES_DE_LECTURA_PK PRIMARY KEY (id_club),
    CONSTRAINT CLUB_EMAIL_UNIQUE UNIQUE (email),
    CONSTRAINT CHECK_MEMBRESIA CHECK(tiene_membresia IN ('S','N')),
    CONSTRAINT CLUB_CIUDADES_FK FOREIGN KEY (id_pais, id_ciudad) 
        REFERENCES ACJJ_CIUDADES (id_pais, id_ciudad),
    CONSTRAINT CLUB_INSTITUCIONES_FK FOREIGN KEY (id_institucion) 
        REFERENCES ACJJ_INSTITUCIONES (id_institucion)
);

-- 
-- 13. ACJJ_CLUBES_ASOCIADOS
-- 
CREATE TABLE ACJJ_CLUBES_ASOCIADOS (
    id_club1 NUMBER(3) NOT NULL,
    id_club2 NUMBER(3) NOT NULL,
    CONSTRAINT CLUBES_ASOCIADOS_PK PRIMARY KEY (id_club1, id_club2),
    CONSTRAINT CLUB_ASOC_FK1 FOREIGN KEY (id_club1) REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club),
    CONSTRAINT CLUB_ASOC_FK2 FOREIGN KEY (id_club2) REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club)
);

-- 
-- 14. ACJJ_IDIOM_CLUB_LEC
-- 
CREATE TABLE ACJJ_IDIOM_CLUB_LEC (
    id        NUMBER(6) NOT NULL,
    id_idioma NUMBER(3) NOT NULL,
    id_lector NUMBER(4),
    id_club   NUMBER(3),
    CONSTRAINT IDIOM_CLUB_LEC_PK PRIMARY KEY (id, id_idioma),
    CONSTRAINT CHECK_ARCO_ICL CHECK (
        ((id_club IS NOT NULL) AND (id_lector IS NULL)) OR 
        ((id_lector IS NOT NULL) AND (id_club IS NULL))
    ),
    CONSTRAINT IDIOM_CLUB_FK FOREIGN KEY (id_club) 
        REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club),
    CONSTRAINT IDIOM_IDIOMAS_FK FOREIGN KEY (id_idioma) 
        REFERENCES ACJJ_IDIOMAS (id_idioma),
    CONSTRAINT IDIOM_LECTORES_FK FOREIGN KEY (id_lector) 
        REFERENCES ACJJ_LECTORES (id_lector)
);

-- 
-- 15. ACJJ_GRUPOS_DE_LECTURA
-- 
CREATE TABLE ACJJ_GRUPOS_DE_LECTURA (
    id_club        NUMBER(3) NOT NULL,
    id_grupo       NUMBER(2) NOT NULL,
    tipo           VARCHAR2(1) NOT NULL,
    fecha_creacion DATE NOT NULL,
    dia_reunion    DATE NOT NULL,
    hora_ini_reu   DATE NOT NULL,
    CONSTRAINT GRUPOS_DE_LECTURA_PK PRIMARY KEY (id_club, id_grupo),
    CONSTRAINT CHECK_TIPO CHECK(tipo IN ('I', 'J', 'A')),
    CONSTRAINT CHECK_DIA CHECK (TO_CHAR(dia_reunion, 'D') IN ('2','3','4','5','6')),
    CONSTRAINT GRU_CLUBES_FK FOREIGN KEY (id_club) 
        REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club)
);

-- 
-- 16. ACJJ_MEMBRESIAS
-- 
CREATE TABLE ACJJ_MEMBRESIAS (
    id_lector     NUMBER(4) NOT NULL,
    id_club       NUMBER(3) NOT NULL,
    id_membresia  NUMBER(5) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    estatus       VARCHAR2(1) NOT NULL,
    fecha_retiro  DATE,
    motivo_retiro VARCHAR2(100),
    CONSTRAINT MEMBRESIAS_PK PRIMARY KEY (id_lector, id_club, id_membresia),
    CONSTRAINT CHECK_ESTATUS CHECK (estatus IN ('A', 'I')),
    CONSTRAINT MEMB_CLUBES_FK FOREIGN KEY (id_club) 
        REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club),
    CONSTRAINT MEMB_LECTORES_FK FOREIGN KEY (id_lector) 
        REFERENCES ACJJ_LECTORES (id_lector)
);

-- 
-- 17. ACJJ_PAGOS
-- 
CREATE TABLE ACJJ_PAGOS (
    id_lector    NUMBER(4) NOT NULL,
    id_club      NUMBER(3) NOT NULL,
    id_membresia NUMBER(5) NOT NULL,
    id_pago      NUMBER(5) NOT NULL,
    fecha_pago   DATE NOT NULL,
    monto        NUMBER(10,2),
    CONSTRAINT PAGOS_PK PRIMARY KEY (id_lector, id_club, id_membresia, id_pago),
    CONSTRAINT PAGOS_MEMBRESIAS_FK FOREIGN KEY (id_lector, id_club, id_membresia) 
        REFERENCES ACJJ_MEMBRESIAS (id_lector, id_club, id_membresia)
);

-- 
-- 18. ACJJ_GRUPOS_LECTORES
-- 
CREATE TABLE ACJJ_GRUPOS_LECTORES (
    id_lector     NUMBER(4) NOT NULL,
    fecha_inicio  DATE NOT NULL,
    id_grupo      NUMBER(2) NOT NULL,
    id_club       NUMBER(3) NOT NULL,
    id_membresia  NUMBER(5) NOT NULL,
    fecha_fin     DATE,
    CONSTRAINT GRUPOS_LECTORES_PK PRIMARY KEY (id_lector, fecha_inicio, id_grupo, id_club, id_membresia),
    CONSTRAINT GL_GRUPOS_FK FOREIGN KEY (id_club, id_grupo)
        REFERENCES ACJJ_GRUPOS_DE_LECTURA (id_club, id_grupo),
    CONSTRAINT GL_MEMBRESIAS_FK FOREIGN KEY (id_lector, id_club, id_membresia) 
        REFERENCES ACJJ_MEMBRESIAS (id_lector, id_club, id_membresia)
);

-- 
-- 19. ACJJ_CALENDARIOS_MES 
-- 
CREATE TABLE ACJJ_CALENDARIOS_MES (
    id_club             NUMBER(3) NOT NULL,
    id_grupo            NUMBER(2) NOT NULL,   
    fecha               DATE NOT NULL,       
    isbn_libro          NUMBER(13) NOT NULL,
    realizado           VARCHAR2(1) NOT NULL,
    mod_id_lector       NUMBER(4) NOT NULL,   
    mod_fecha_inicio    DATE NOT NULL,        
    mod_id_grupo        NUMBER(2) NOT NULL,   
    mod_id_club         NUMBER(3) NOT NULL,   
    mod_id_membresia    NUMBER(5) NOT NULL,   
    ult_reunion         VARCHAR2(1),
    conclusiones        VARCHAR2(2000),
    valoracion          NUMBER(1),
    CONSTRAINT CALENDARIOS_MES_PK PRIMARY KEY (id_club, id_grupo, fecha),
    CONSTRAINT CHECK_ULT_REU CHECK (ult_reunion IN ('S', 'N')),
    CONSTRAINT CHECK_CON_VAL CHECK (
        (ult_reunion = 'S' AND conclusiones IS NOT NULL AND valoracion IS NOT NULL) OR 
        (ult_reunion = 'N' AND conclusiones IS NULL AND valoracion IS NULL) OR
        (ult_reunion IS NULL AND conclusiones IS NULL AND valoracion IS NULL)
    ),
    CONSTRAINT CAL_GRUPOS_FK FOREIGN KEY (id_club, id_grupo) 
        REFERENCES ACJJ_GRUPOS_DE_LECTURA (id_club, id_grupo),
    CONSTRAINT CAL_LIBROS_FK FOREIGN KEY (isbn_libro) 
        REFERENCES ACJJ_LIBROS (isbn),
    CONSTRAINT CAL_MODERADOR_GRUPOS_FK FOREIGN KEY (mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia) 
        REFERENCES ACJJ_GRUPOS_LECTORES (id_lector, fecha_inicio, id_grupo, id_club, id_membresia),
    CONSTRAINT CHECK_MISMO_CLUB CHECK (id_club = mod_id_club)
);

-- 
-- 20. ACJJ_INASISTENCIAS
-- 
CREATE TABLE ACJJ_INASISTENCIAS (
    id_lector    NUMBER(4) NOT NULL,
    id_club      NUMBER(3) NOT NULL,
    id_grupo     NUMBER(2) NOT NULL,
    cal_fecha    DATE NOT NULL,
    id_membresia NUMBER(5) NOT NULL,
    fecha_ini_gl DATE NOT NULL,
    CONSTRAINT INASISTENCIAS_PK PRIMARY KEY (id_lector, id_club, id_grupo, cal_fecha, id_membresia, fecha_ini_gl),
    CONSTRAINT INAS_GRUPOS_LEC_FK FOREIGN KEY (id_lector, fecha_ini_gl, id_grupo, id_club, id_membresia) 
        REFERENCES ACJJ_GRUPOS_LECTORES (id_lector, fecha_inicio, id_grupo, id_club, id_membresia),
    CONSTRAINT INAS_CALENDARIOS_FK FOREIGN KEY (id_club, id_grupo, cal_fecha) 
        REFERENCES ACJJ_CALENDARIOS_MES (id_club, id_grupo, fecha)
);

-- 
-- 21. ACJJ_OBRAS_TEATRALES 
-- 
CREATE TABLE ACJJ_OBRAS_TEATRALES (
    id_club       NUMBER(3) NOT NULL,
    id_obra       NUMBER(3) NOT NULL,
    isbn_libro    NUMBER(13) NOT NULL,
    estatus       VARCHAR2(8) NOT NULL,
    costo_entrada NUMBER(8,2),
    CONSTRAINT OBRAS_TEATRALES_PK PRIMARY KEY (id_club, isbn_libro, id_obra),
    CONSTRAINT CHECK_ESTATUS_OBRA CHECK (estatus IN ('A','I')),
    CONSTRAINT OBRAS_CLUBES_FK FOREIGN KEY (id_club) 
        REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club),
    CONSTRAINT OBRAS_LIBROS_FK FOREIGN KEY (isbn_libro) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 
-- 22. ACJJ_ELENCOS
-- 
CREATE TABLE ACJJ_ELENCOS (
    id_obra   NUMBER(3) NOT NULL,
    id_actor  NUMBER(4) NOT NULL,
    id_club   NUMBER(3) NOT NULL,
    isbn_obra NUMBER(13) NOT NULL,
    CONSTRAINT ELENCOS_PK PRIMARY KEY (id_obra, id_actor, isbn_obra, id_club),
    CONSTRAINT ELE_OBRAS_FK FOREIGN KEY (id_club, isbn_obra, id_obra) 
        REFERENCES ACJJ_OBRAS_TEATRALES (id_club, isbn_libro, id_obra),
    CONSTRAINT ELE_LECTORES_FK FOREIGN KEY (id_actor) 
        REFERENCES ACJJ_LECTORES (id_lector)
);

-- 
-- 23. ACJJ_PRESENTACIONES
-- 
CREATE TABLE ACJJ_PRESENTACIONES (
    id_obra       NUMBER(3) NOT NULL,
    id_club       NUMBER(3) NOT NULL,
    fecha         DATE NOT NULL,
    isbn_lib_obra NUMBER(13) NOT NULL,
    ent_vendidas  NUMBER(3) NOT NULL,
    estrellas_obt NUMBER(1) NOT NULL,
    CONSTRAINT PRESENTACIONES_PK PRIMARY KEY (id_obra, id_club, fecha, isbn_lib_obra),
    CONSTRAINT CHECK_ESTRELLAS CHECK (estrellas_obt IN (1,2,3,4,5)),
    CONSTRAINT PRES_OBRAS_FK FOREIGN KEY (id_club, isbn_lib_obra, id_obra) 
        REFERENCES ACJJ_OBRAS_TEATRALES (id_club, isbn_libro, id_obra)
);

-- 
-- 24. ACJJ_MEJORES_ACTORES
-- 
CREATE TABLE ACJJ_MEJORES_ACTORES (
    fecha_pres   DATE NOT NULL,
    id_actor     NUMBER(4) NOT NULL,
    id_obra      NUMBER(3) NOT NULL,
    isbn         NUMBER(13) NOT NULL,
    id_club      NUMBER(3) NOT NULL,
    CONSTRAINT MEJORES_ACTORES_PK PRIMARY KEY (fecha_pres, id_actor, id_obra, isbn, id_club),
    CONSTRAINT MA_ELENCOS_FK FOREIGN KEY (id_obra, id_actor, isbn, id_club) 
        REFERENCES ACJJ_ELENCOS (id_obra, id_actor, isbn_obra, id_club),
    CONSTRAINT MA_PRESENTACIONES_FK FOREIGN KEY (id_obra, id_club, fecha_pres, isbn) 
        REFERENCES ACJJ_PRESENTACIONES (id_obra, id_club, fecha, isbn_lib_obra)
);

-- 
-- CREATES DE ÍNDICES 
-- 

-- 7. ACJJ_LIBROS
CREATE INDEX ACJJ_LIBROS_FK_PAIS_IDX ON ACJJ_LIBROS (id_pais);
CREATE INDEX ACJJ_LIBROS_FK_ANTERIOR_IDX ON ACJJ_LIBROS (isbn_lib_anterior);

-- 9. ACJJ_LECTORES
CREATE INDEX ACJJ_LECTORES_FK_PAIS_IDX ON ACJJ_LECTORES (id_pais);
CREATE INDEX ACJJ_LECTORES_FK_REP_IDX ON ACJJ_LECTORES (id_rep);
CREATE INDEX ACJJ_LECTORES_FK_LECTOR_REP_IDX ON ACJJ_LECTORES (id_lector_rep);

-- 10. ACJJ_TELEFONOS
CREATE INDEX ACJJ_TELEFONOS_FK_LECTOR_IDX ON ACJJ_TELEFONOS (id_lector);
CREATE INDEX ACJJ_TELEFONOS_FK_REP_IDX ON ACJJ_TELEFONOS (id_rep);

-- 12. ACJJ_CLUBES_DE_LECTURA
CREATE INDEX ACJJ_CLUB_FK_CIUDAD_PAIS_IDX ON ACJJ_CLUBES_DE_LECTURA (id_pais, id_ciudad);
CREATE INDEX ACJJ_CLUB_FK_INSTITUCION_IDX ON ACJJ_CLUBES_DE_LECTURA (id_institucion);

-- 13. ACJJ_CLUBES_ASOCIADOS
CREATE INDEX ACJJ_CLUB_ASOC_FK2_IDX ON ACJJ_CLUBES_ASOCIADOS (id_club2);

-- 14. ACJJ_IDIOM_CLUB_LEC
CREATE INDEX ACJJ_IDIOM_CLUB_FK_CLUB_IDX ON ACJJ_IDIOM_CLUB_LEC (id_club);
CREATE INDEX ACJJ_IDIOM_CLUB_FK_LECTOR_IDX ON ACJJ_IDIOM_CLUB_LEC (id_lector);

-- 16. ACJJ_MEMBRESIAS
CREATE INDEX ACJJ_MEMB_FK_CLUBES_IDX ON ACJJ_MEMBRESIAS (id_club);

-- 18. ACJJ_GRUPOS_LECTORES
CREATE INDEX ACJJ_GL_FK_MEMBRESIAS_IDX ON ACJJ_GRUPOS_LECTORES (id_lector, id_club, id_membresia);

-- 19. ACJJ_CALENDARIOS_MES
CREATE INDEX ACJJ_CAL_FK_LIBROS_IDX ON ACJJ_CALENDARIOS_MES (isbn_libro);
CREATE INDEX ACJJ_CAL_FK_MODERADOR_IDX ON ACJJ_CALENDARIOS_MES (mod_id_lector, mod_fecha_inicio, mod_id_grupo, mod_id_club, mod_id_membresia);

-- 20. ACJJ_INASISTENCIAS 
CREATE INDEX ACJJ_INAS_FK_CALENDARIOS_IDX ON ACJJ_INASISTENCIAS (id_club, id_grupo, cal_fecha);

-- 21. ACJJ_OBRAS_TEATRALES
CREATE INDEX ACJJ_OBRAS_FK_LIBROS_IDX ON ACJJ_OBRAS_TEATRALES (isbn_libro);

-- 22. ACJJ_ELENCOS
CREATE INDEX ACJJ_ELE_FK_LECTORES_IDX ON ACJJ_ELENCOS (id_actor);

-- 24. ACJJ_MEJORES_ACTORES 
CREATE INDEX ACJJ_MA_FK_ELENCOS_IDX ON ACJJ_MEJORES_ACTORES (id_obra, id_actor, isbn, id_club);
CREATE INDEX ACJJ_MA_FK_PRESENTACIONES_IDX ON ACJJ_MEJORES_ACTORES (id_obra, id_club, fecha_pres, isbn);

-- INDICES ADICIONALES 

CREATE INDEX ACJJ_LIB_TITULO_IDX ON ACJJ_LIBROS (titulo);
CREATE INDEX ACJJ_LEC_NOMBRE_COMP_IDX ON ACJJ_LECTORES (p_apellido, s_apellido, p_nombre);
CREATE INDEX ACJJ_REP_NOMBRE_COMP_IDX ON ACJJ_REPRESENTANTES (p_apellido, s_apellido, p_nombre);

-- 
-- CREATES DE SECUENCIAS 
-- 

-- 1. Secuencia para ACJJ_PAISES.id_pais
CREATE SEQUENCE ACJJ_PAISES_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 2. Secuencia para ACJJ_AUTORES.id_autor
CREATE SEQUENCE ACJJ_AUTORES_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999;

-- 3. Secuencia para ACJJ_INSTITUCIONES.id_institucion
CREATE SEQUENCE ACJJ_INSTITUCIONES_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 4. Secuencia para ACJJ_REPRESENTANTES.id_rep
CREATE SEQUENCE ACJJ_REPRESENTANTES_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 5. Secuencia para ACJJ_IDIOMAS.id_idioma
CREATE SEQUENCE ACJJ_IDIOMAS_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 9. Secuencia para ACJJ_LECTORES.id_lector
CREATE SEQUENCE ACJJ_LECTORES_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999;

-- 10. Secuencia para ACJJ_TELEFONOS.id_tel
CREATE SEQUENCE ACJJ_TELEFONOS_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999;

-- 12. Secuencia para ACJJ_CLUBES_DE_LECTURA.id_club
CREATE SEQUENCE ACJJ_CLUBES_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999;

-- 14. Secuencia para ACJJ_IDIOM_CLUB_LEC.id 
CREATE SEQUENCE ACJJ_IDIOM_CLUB_LEC_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999999;

--
-- CREATES DE VISTAS
-- 

-- 1. Vista: Catálogo de libros con sus autores respectivos
CREATE OR REPLACE VIEW ACJJ_V_LIBROS_CON_AUTORES AS
SELECT l.isbn, l.titulo, EXTRACT(YEAR FROM l.ano_publicacion) AS anio_publicacion,
       p.nombre_pais AS pais_publicacion,
       CASE 
         WHEN a.pseudonimo IS NOT NULL THEN a.pseudonimo 
         ELSE a.nombre || ' ' || a.apellido 
       END AS autor
FROM ACJJ_LIBROS l, ACJJ_PAISES p, ACJJ_LIBROS_AUTORES la, ACJJ_AUTORES a
WHERE l.id_pais = p.id_pais
  AND l.isbn = la.isbn
  AND la.id_autor = a.id_autor;


-- 2. Vista: Directorio de clubes de lectura 
CREATE OR REPLACE VIEW ACJJ_V_DIRECTORIO_CLUBES AS
SELECT c.id_club, c.nombre_club,
       ci.nombre_ciudad, p.nombre_pais,
       c.tiene_membresia,
       (SELECT inst.nombre FROM ACJJ_INSTITUCIONES inst WHERE inst.id_institucion = c.id_institucion) AS nombre_institucion,
       (SELECT inst.tipo FROM ACJJ_INSTITUCIONES inst WHERE inst.id_institucion = c.id_institucion) AS tipo_institucion
FROM ACJJ_CLUBES_DE_LECTURA c, ACJJ_CIUDADES ci, ACJJ_PAISES p
WHERE c.id_ciudad = ci.id_ciudad
  AND c.id_pais = ci.id_pais
  AND ci.id_pais = p.id_pais;


-- 3. Vista: Membresías activas en el sistema
CREATE OR REPLACE VIEW ACJJ_V_MEMBRESIAS_ACTIVAS AS
SELECT m.id_membresia, 
       l.p_nombre || ' ' || l.p_apellido AS lector,
       c.nombre_club, m.fecha_ingreso
FROM ACJJ_MEMBRESIAS m, ACJJ_LECTORES l, ACJJ_CLUBES_DE_LECTURA c
WHERE m.id_lector = l.id_lector
  AND m.id_club = c.id_club
  AND m.estatus = 'A';


-- 4. Vista: Historial de reuniones y lecturas completadas 
CREATE OR REPLACE VIEW ACJJ_V_HISTORIAL_LECTURAS AS
SELECT cal.fecha, c.nombre_club,
       lib.titulo AS libro_analizado,
       cal.valoracion
FROM ACJJ_CALENDARIOS_MES cal, ACJJ_CLUBES_DE_LECTURA c, ACJJ_LIBROS lib
WHERE cal.id_club = c.id_club
  AND cal.isbn_libro = lib.isbn
  AND cal.realizado = 'S';


-- 5. Vista: Fusión de Edad y Antigüedad del Miembro 
CREATE OR REPLACE VIEW ACJJ_V_EDAD_ANTIGUEDAD AS
SELECT l.id_lector, 
       l.p_nombre || ' ' || l.p_apellido AS lector,
       TRUNC(MONTHS_BETWEEN(SYSDATE, l.fecha_nac)/12) AS edad_anos,
       c.nombre_club,
       TRUNC(MONTHS_BETWEEN(SYSDATE, m.fecha_ingreso)) AS meses_antiguedad,
       m.estatus AS estatus_membresia
FROM ACJJ_LECTORES l, ACJJ_MEMBRESIAS m, ACJJ_CLUBES_DE_LECTURA c
WHERE l.id_lector = m.id_lector
  AND m.id_club = c.id_club;


-- 6. Vista: Ficha resumen del club 
CREATE OR REPLACE VIEW ACJJ_V_FICHA_CLUB AS
SELECT c.id_club, c.nombre_club,
       (SELECT COUNT(*) FROM ACJJ_MEMBRESIAS m WHERE m.id_club = c.id_club AND m.estatus = 'A') AS total_miembros_activos,
       (SELECT COUNT(*) FROM ACJJ_GRUPOS_DE_LECTURA g WHERE g.id_club = c.id_club) AS total_grupos
FROM ACJJ_CLUBES_DE_LECTURA c;


-- 7. Vista: Reporte analítico de libros y estrellas promedio 
CREATE OR REPLACE VIEW ACJJ_V_RPT_FICHA_LIBRO AS
SELECT l.isbn, l.titulo,
       (SELECT COUNT(*) FROM ACJJ_CALENDARIOS_MES cal WHERE cal.isbn_libro = l.isbn AND cal.realizado = 'S') AS veces_analizado,
       (SELECT ROUND(AVG(cal.valoracion), 2) FROM ACJJ_CALENDARIOS_MES cal WHERE cal.isbn_libro = l.isbn AND cal.realizado = 'S') AS promedio_estrellas
FROM ACJJ_LIBROS l;


-- 8. Vista: Reporte analítico - Crecimiento anual de miembros 
CREATE OR REPLACE VIEW ACJJ_V_RPT_CRECIMIENTO_CLUBES AS
WITH Miembros_Por_Anio AS (
    SELECT m.id_club, EXTRACT(YEAR FROM m.fecha_ingreso) AS anio, COUNT(m.id_lector) AS nuevos_miembros
    FROM ACJJ_MEMBRESIAS m
    GROUP BY m.id_club, EXTRACT(YEAR FROM m.fecha_ingreso)
)
SELECT c.nombre_club, t1.anio AS anio_actual, t1.nuevos_miembros,
       NVL(t2.nuevos_miembros, 0) AS miembros_anio_anterior,
       CASE 
         WHEN NVL(t2.nuevos_miembros, 0) = 0 THEN 100
         ELSE ROUND(((t1.nuevos_miembros - t2.nuevos_miembros) / t2.nuevos_miembros) * 100, 2)
       END AS porcentaje_crecimiento
FROM ACJJ_CLUBES_DE_LECTURA c, Miembros_Por_Anio t1, Miembros_Por_Anio t2
WHERE c.id_club = t1.id_club
  AND t1.id_club = t2.id_club (+)
  AND t1.anio = t2.anio (+) + 1;