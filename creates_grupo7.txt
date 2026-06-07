--
-- CREATE DE LAS TABLAS
--
-- 1. ACJJ_PAISES
CREATE TABLE ACJJ_PAISES (
    id_pais      NUMBER(3) NOT NULL,
    nombre_pais  VARCHAR2(15) NOT NULL,
    moneda_local VARCHAR2(3) NOT NULL,
    nacionalidad VARCHAR2(20) NOT NULL,
    CONSTRAINT PAISES_PK PRIMARY KEY (id_pais),
    CONSTRAINT PAIS_UNIQUE UNIQUE (nombre_pais)
);

-- 2. ACJJ_AUTORES
CREATE TABLE ACJJ_AUTORES (
    id_autor   NUMBER(4) NOT NULL,
    nombre     VARCHAR2(15),
    apellido   VARCHAR2(15),
    pseudonimo VARCHAR2(15),
        CONSTRAINT AUTORES_PK PRIMARY KEY (id_autor),
    CONSTRAINT CHECK_AL_MENOS_UN_NOMBRE CHECK (nombre IS NOT NULL 
        OR apellido IS NOT NULL or pseudonimo IS NOT NULL)
);

-- 3. ACJJ_INSTITUCIONES
CREATE TABLE ACJJ_INSTITUCIONES (
    id_institucion NUMBER(3) NOT NULL,
    nombre         VARCHAR2(30) NOT NULL,
    tipo           VARCHAR2(11) NOT NULL,
    CONSTRAINT INSTITUCIONES_PK PRIMARY KEY (id_institucion),
    CONSTRAINT CHECK_TIPO_INSTITUCION CHECK (tipo in ('BIBLIOTECA', 'UNIVERSIDAD', 'COLEGIO', 'OTRO'))
);

-- 4. ACJJ_REPRESENTANTES
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

-- 5. ACJJ_IDIOMAS
CREATE TABLE ACJJ_IDIOMAS (
    id_idioma NUMBER(3) NOT NULL,
    nombre    VARCHAR2(15) NOT NULL,
    CONSTRAINT IDIOMAS_PK PRIMARY KEY (id_idioma),
    CONSTRAINT IDIOMA_UNIQUE UNIQUE (nombre)
);

-- 6. ACJJ_CIUDADES
CREATE TABLE ACJJ_CIUDADES (
    id_pais       NUMBER(3) NOT NULL,
    id_ciudad     NUMBER(5) NOT NULL,
    nombre_ciudad VARCHAR2(30) NOT NULL,
    CONSTRAINT CIUDADES_PK PRIMARY KEY (id_pais, id_ciudad),
    CONSTRAINT CIUDADES_PAISES_FK FOREIGN KEY (id_pais) 
        REFERENCES ACJJ_PAISES (id_pais)
);

-- 7. ACJJ_LIBROS
CREATE TABLE ACJJ_LIBROS (
    isbn            NUMBER(13) NOT NULL,
    titulo          VARCHAR2(100) NOT NULL,
    ano_publicacion DATE NOT NULL,
    can_paginas     NUMBER(4) NOT NULL,
    sinopsis        VARCHAR2(2000) NOT NULL,
    tipo_narrativa  VARCHAR2(15) NOT NULL,
    temas           VARCHAR2(40) NOT NULL,
    id_pais         NUMBER(3) NOT NULL,
    isbn_lib_anterior NUMBER(13),
    isbn_lib_sig   NUMBER(13),
    CONSTRAINT LIBROS_PK PRIMARY KEY (isbn),
    CONSTRAINT LIBROS_PAISES_FK FOREIGN KEY (id_pais) 
        REFERENCES ACJJ_PAISES (id_pais),
    CONSTRAINT LIBROS_AN_FK FOREIGN KEY (isbn_lib_anterior) 
        REFERENCES ACJJ_LIBROS (isbn),
    CONSTRAINT LIBROS_SIG_FK FOREIGN KEY (isbn_lib_sig) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 8. ACJJ_LIBROS_AUTORES
CREATE TABLE ACJJ_LIBROS_AUTORES (
    isbn     NUMBER(13) NOT NULL,
    id_autor NUMBER(4) NOT NULL,
    CONSTRAINT LIBROS_AUTORES_PK PRIMARY KEY (isbn, id_autor),
    CONSTRAINT LIB_AUT_AUTORES_FK FOREIGN KEY (id_autor) 
        REFERENCES ACJJ_AUTORES (id_autor),
    CONSTRAINT LIB_AUT_LIBROS_FK FOREIGN KEY (isbn) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 9. ACJJ_LECTORES
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
    CONSTRAINT CHECK_ARCO_REP CHECK((id_rep IS NULL and id_lector_rep IS NOT NULL) 
        OR (id_rep IS NOT NULL and id_lector_rep IS NULL)),
    CONSTRAINT LEC_REPRESENTANTES_FK FOREIGN KEY (id_rep) 
        REFERENCES ACJJ_REPRESENTANTES (id_rep),
    CONSTRAINT LEC_LECTORES_FK FOREIGN KEY (id_lector_rep) 
        REFERENCES ACJJ_LECTORES (id_lector)
);

-- 10. ACJJ_TELEFONOS
CREATE TABLE ACJJ_TELEFONOS (
    id_tel        NUMBER(4) NOT NULL,
    codigo_pais   NUMBER(3) NOT NULL,
    codigo_area   NUMBER(6) NOT NULL,
    numero        NUMBER(20) NOT NULL,
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

-- 11. ACJJ_LIBROS_PREFERIDOS
CREATE TABLE ACJJ_LIBROS_PREFERIDOS (
    id_lector  NUMBER(4) NOT NULL,
    orden_pref NUMBER(1) NOT NULL,
    isbn       NUMBER(13) NOT NULL,
    CONSTRAINT LIBROS_PREF_PK PRIMARY KEY (id_lector, orden_pref, isbn),
    CONSTRAINT CHECK_ORDEN_PREF CHECK (orden_pref in (1,2,3)),
    CONSTRAINT LIB_PREF_LECTORES_FK FOREIGN KEY (id_lector) 
        REFERENCES ACJJ_LECTORES (id_lector),
    CONSTRAINT LIB_PREF_LIBROS_FK FOREIGN KEY (isbn) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 12. ACJJ_CLUBES_DE_LECTURA
CREATE TABLE ACJJ_CLUBES_DE_LECTURA (
    id_club         NUMBER(3) NOT NULL,
    nombre_club     VARCHAR2(30) NOT NULL,
    email           VARCHAR2(50) NOT NULL,
    direccion       VARCHAR2(50) NOT NULL,
    cod_postal      VARCHAR2(10) NOT NULL,
    id_ciudad       NUMBER(5) NOT NULL,
    id_pais         NUMBER(3) NOT NULL,
    tiene_membresia VARCHAR2(1),
    id_institucion  NUMBER(3),
    CONSTRAINT CLUBES_DE_LECTURA_PK PRIMARY KEY (id_club),
    CONSTRAINT CLUB_EMAIL_UNIQUE UNIQUE (email),
    CONSTRAINT CHECK_MEMBRESIA CHECK(tiene_membresia in ('S','N')),
    CONSTRAINT CLUB_CIUDADES_FK FOREIGN KEY (id_pais, id_ciudad) 
        REFERENCES ACJJ_CIUDADES (id_pais, id_ciudad),
    CONSTRAINT CLUB_INSTITUCIONES_FK FOREIGN KEY (id_institucion) 
        REFERENCES ACJJ_INSTITUCIONES (id_institucion)
);

-- 13. ACJJ_CLUBES_ASOCIADOS
CREATE TABLE ACJJ_CLUBES_ASOCIADOS (
    id_club1 NUMBER(3) NOT NULL,
    id_club2 NUMBER(3) NOT NULL,
    CONSTRAINT CLUBES_ASOCIADOS_PK PRIMARY KEY (id_club1, id_club2),
    CONSTRAINT CLUB_ASOC_FK1 FOREIGN KEY (id_club1) REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club),
    CONSTRAINT CLUB_ASOC_FK2 FOREIGN KEY (id_club2) REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club)
);

-- 14. ACJJ_IDIOM_CLUB_LEC
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

-- 15. ACJJ_GRUPOS_DE_LECTURA
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

-- 16. ACJJ_MEMBRESIAS
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

-- 17. ACJJ_PAGOS
CREATE TABLE ACJJ_PAGOS (
    id_lector    NUMBER(4) NOT NULL,
    id_club      NUMBER(3) NOT NULL,
    id_membresia NUMBER(5) NOT NULL,
    id_pago      NUMBER(5) NOT NULL,
    fecha_pago   DATE NOT NULL,
    CONSTRAINT PAGOS_PK PRIMARY KEY (id_lector, id_club, id_membresia, id_pago),
    CONSTRAINT PAGOS_MEMBRESIAS_FK FOREIGN KEY (id_lector, id_club, id_membresia) 
        REFERENCES ACJJ_MEMBRESIAS (id_lector, id_club, id_membresia)
);

-- 18. ACJJ_GRUPOS_LECTORES
CREATE TABLE ACJJ_GRUPOS_LECTORES (
    id_lector     NUMBER(4) NOT NULL,
    fecha_inicio  DATE NOT NULL,
    id_grupo      NUMBER(2) NOT NULL,
    id_club_g     NUMBER(3) NOT NULL,
    id_membresia  NUMBER(5) NOT NULL,
    id_club_m     NUMBER(3) NOT NULL,
    fecha_fin     DATE,
    CONSTRAINT GRUPOS_LECTORES_PK PRIMARY KEY (id_lector, fecha_inicio, id_grupo, id_club_g, id_membresia, id_club_m),
    CONSTRAINT GL_GRUPOS_FK FOREIGN KEY (id_grupo, id_club_g)
        REFERENCES ACJJ_GRUPOS_DE_LECTURA (id_grupo, id_club),
    CONSTRAINT GL_MEMBRESIAS_FK FOREIGN KEY (id_lector, id_club_m, id_membresia) 
        REFERENCES ACJJ_MEMBRESIAS (id_lector, id_club, id_membresia)
);

-- 19. ACJJ_CALENDARIOS_MES
CREATE TABLE ACJJ_CALENDARIOS_MES (
    id_grupo     NUMBER(2) NOT NULL,
    fecha        DATE NOT NULL,
    id_club      NUMBER(3) NOT NULL,
    isbn_libro   NUMBER(13) NOT NULL,
    realizado    NUMBER NOT NULL,
    mod_fecha_ini DATE NOT NULL,
    mod_id_grupo  NUMBER(2) NOT NULL,
    mod_id_clubg  NUMBER(3) NOT NULL,
    mod_moderador_memb   NUMBER(5) NOT NULL,
    id_moderador NUMBER(4) NOT NULL,
    mod_id_club  NUMBER(3) NOT NULL,
    ult_reunion  VARCHAR2(1),
    conclusiones VARCHAR2(2000),
    valoracion   NUMBER(5),
    CONSTRAINT CALENDARIOS_MES_PK PRIMARY KEY (id_grupo ,fecha, id_club),
    CONSTRAINT CHECK_ULT_REU CHECK (ult_reunion in ('S','N')),
    CONSTRAINT CAL_GRUPOS_FK FOREIGN KEY (id_grupo, id_club) 
        REFERENCES ACJJ_GRUPOS_DE_LECTURA (id_grupo, id_club),
    CONSTRAINT CAL_LIBROS_FK FOREIGN KEY (isbn_libro) 
        REFERENCES ACJJ_LIBROS (isbn),
    CONSTRAINT CAL_MODERADOR_FK FOREIGN KEY (mod_fecha_ini, mod_id_clubg, mod_id_grupo, id_moderador, mod_moderador_memb, mod_id_club) 
        REFERENCES ACJJ_GRUPOS_LECTORES (fecha_inicio, id_club_g, id_grupo, id_lector, id_membresia, id_club_m)
);

-- 20. ACJJ_INASISTENCIAS
CREATE TABLE ACJJ_INASISTENCIAS (
    id_lector    NUMBER(4) NOT NULL,
    id_grupo     NUMBER(2) NOT NULL,
    id_club_g    NUMBER(3) NOT NULL,
    id_membresia NUMBER(5) NOT NULL,
    fecha_ini_g  DATE NOT NULL,
    id_club_m    NUMBER(3) NOT NULL,
    cal_fecha    DATE NOT NULL,
    cal_id_grupo NUMBER(2) NOT NULL,
    cal_id_club  NUMBER(3) NOT NULL,
    CONSTRAINT INASISTENCIAS_PK PRIMARY KEY (id_lector, id_grupo, id_membresia, id_club_g, fecha_ini_g, id_club_m, cal_fecha, cal_id_grupo, cal_id_club),
    CONSTRAINT INAS_GRUPOS_LEC_FK FOREIGN KEY (fecha_ini_g, id_club_g, id_grupo, id_lector, id_membresia, id_club_m) 
        REFERENCES ACJJ_GRUPOS_LECTORES (fecha_inicio, id_club_g, id_grupo, id_lector, id_membresia, id_club_m),
    CONSTRAINT INAS_CALENDARIOS_FK FOREIGN KEY (cal_fecha, cal_id_grupo, cal_id_club) 
        REFERENCES ACJJ_CALENDARIOS_MES (fecha, id_grupo, id_club)
);

-- 21. ACCJ_OBRAS_TEATRALES
CREATE TABLE ACCJ_OBRAS_TEATRALES (
    id_club       NUMBER(3) NOT NULL,
    id_obra       NUMBER(3) NOT NULL,
    isbn_libro    NUMBER(13) NOT NULL,
    estatus       VARCHAR2(8) NOT NULL,
    costo_entrada NUMBER(4,2),
    CONSTRAINT OBRAS_TEATRALES_PK PRIMARY KEY (id_club, isbn_libro, id_obra),
    CONSTRAINT OBRAS_CLUBES_FK FOREIGN KEY (id_club) 
        REFERENCES ACJJ_CLUBES_DE_LECTURA (id_club),
    CONSTRAINT OBRAS_LIBROS_FK FOREIGN KEY (isbn_libro) 
        REFERENCES ACJJ_LIBROS (isbn)
);

-- 22. ACJJ_ELENCOS
CREATE TABLE ACJJ_ELENCOS (
    id_obra   NUMBER(3) NOT NULL,
    id_actor NUMBER(4) NOT NULL,
    id_club   NUMBER(3) NOT NULL,
    isbn_obra NUMBER(13) NOT NULL,
    CONSTRAINT ELENCOS_PK PRIMARY KEY (id_obra, id_actor, isbn_obra, id_club),
    CONSTRAINT ELE_OBRAS_FK FOREIGN KEY (id_obra, isbn_obra, id_club) 
        REFERENCES ACCJ_OBRAS_TEATRALES (id_obra, isbn_libro, id_club),
    CONSTRAINT ELE_LECTORES_FK FOREIGN KEY (id_actor) 
        REFERENCES ACJJ_LECTORES (id_lector)
);

-- 23. ACJJ_PRESENTACIONES
CREATE TABLE ACJJ_PRESENTACIONES (
    id_obra       NUMBER(3) NOT NULL,
    id_club       NUMBER(3) NOT NULL,
    fecha         DATE NOT NULL,
    isbn_lib_obra NUMBER(13) NOT NULL,
    ent_vendidas  NUMBER(3) NOT NULL,
    estrellas     NUMBER(1) NOT NULL,
    CONSTRAINT PRESENTACIONES_PK PRIMARY KEY (id_obra, id_club, fecha, isbn_lib_obra),
    CONSTRAINT CHECK_ESTRELLAS CHECK (estrellas in (1,2,3,4,5)),
    CONSTRAINT PRES_OBRAS_FK FOREIGN KEY (id_obra, isbn_lib_obra, id_club) 
        REFERENCES ACCJ_OBRAS_TEATRALES (id_obra, isbn_libro, id_club)
);

-- 24. ACCJ_MEJORES_ACTORES
CREATE TABLE ACCJ_MEJORES_ACTORES (
    fecha_pres   DATE NOT NULL,
    id_actor    NUMBER(4) NOT NULL,
    id_obra_pres NUMBER(3) NOT NULL,
    isbn_pres    NUMBER(13) NOT NULL,
    id_club_pres NUMBER(3) NOT NULL,
    id_obra_el   NUMBER(3) NOT NULL,
    isbn_el      NUMBER(13) NOT NULL,
    id_club_el   NUMBER(3) NOT NULL,
    CONSTRAINT MEJORES_ACTORES_PK PRIMARY KEY (fecha_pres, id_actor, id_obra_pres, isbn_pres, id_club_pres, id_obra_el, isbn_el, id_club_el),
    CONSTRAINT MA_ELENCOS_FK FOREIGN KEY (id_actor, id_obra_el, isbn_el, id_club_el) 
        REFERENCES ACJJ_ELENCOS (id_actor, id_obra, isbn_obra, id_club),
    CONSTRAINT MA_PRESENTACIONES_FK FOREIGN KEY (fecha_pres, id_obra_pres, isbn_pres, id_club_pres) 
        REFERENCES ACJJ_PRESENTACIONES (fecha, id_obra, isbn_lib_obra, id_club)
);

--
-- CREATES DE INDICES
--

-- INDICES PARA CLAVES FORÁNEAS (FK) QUE NO SON CLAVES PRIMARIAS (PK)

-- 7. ACJJ_LIBROS
CREATE INDEX ACJJ_LIBROS_FK_PAIS_IDX 
    ON ACJJ_LIBROS (id_pais);

CREATE INDEX ACJJ_LIBROS_FK_ANTERIOR_IDX 
    ON ACJJ_LIBROS (isbn_lib_anterior);

CREATE INDEX ACJJ_LIBROS_FK_SIG_IDX 
    ON ACJJ_LIBROS (isbn_lib_sig);

-- 9. ACJJ_LECTORES
CREATE INDEX ACJJ_LECTORES_FK_PAIS_IDX 
    ON ACJJ_LECTORES (id_pais);

CREATE INDEX ACJJ_LECTORES_FK_REP_IDX 
    ON ACJJ_LECTORES (id_rep);

CREATE INDEX ACJJ_LECTORES_FK_LECTOR_REP_IDX 
    ON ACJJ_LECTORES (id_lector_rep);

-- 10. ACJJ_TELEFONOS
CREATE INDEX ACJJ_TELEFONOS_FK_LECTOR_IDX 
    ON ACJJ_TELEFONOS (id_lector);

CREATE INDEX ACJJ_TELEFONOS_FK_REP_IDX 
    ON ACJJ_TELEFONOS (id_rep);

-- 12. ACJJ_CLUBES_DE_LECTURA
CREATE INDEX ACJJ_CLUB_FK_CIUDAD_PAIS_IDX 
    ON ACJJ_CLUBES_DE_LECTURA (id_pais, id_ciudad);

CREATE INDEX ACJJ_CLUB_FK_INSTITUCION_IDX 
    ON ACJJ_CLUBES_DE_LECTURA (id_institucion);

-- 13. ACJJ_CLUBES_ASOCIADOS
CREATE INDEX ACJJ_CLUB_ASOC_FK2_IDX 
    ON ACJJ_CLUBES_ASOCIADOS (id_club2);

-- 14. ACJJ_IDIOM_CLUB_LEC
CREATE INDEX ACJJ_IDIOM_CLUB_FK_CLUB_IDX 
    ON ACJJ_IDIOM_CLUB_LEC (id_club);

CREATE INDEX ACJJ_IDIOM_CLUB_FK_LECTOR_IDX 
    ON ACJJ_IDIOM_CLUB_LEC (id_lector);

-- 16. ACJJ_MEMBRESIAS
CREATE INDEX ACJJ_MEMB_FK_CLUBES_IDX 
    ON ACJJ_MEMBRESIAS (id_club);

-- 18. ACJJ_GRUPOS_LECTORES
CREATE INDEX ACJJ_GL_FK_GRUPOS_IDX 
    ON ACJJ_GRUPOS_LECTORES (id_grupo, id_club_g);

CREATE INDEX ACJJ_GL_FK_MEMBRESIAS_IDX 
    ON ACJJ_GRUPOS_LECTORES (id_lector, id_club_m, id_membresia);

-- 19. ACJJ_CALENDARIOS_MES
CREATE INDEX ACJJ_CAL_FK_LIBROS_IDX 
    ON ACJJ_CALENDARIOS_MES (isbn_libro);

CREATE INDEX ACJJ_CAL_FK_MODERADOR_IDX 
    ON ACJJ_CALENDARIOS_MES (mod_fecha_ini, mod_id_clubg, mod_id_grupo, id_moderador, mod_moderador_memb, mod_id_club);

-- 20. ACJJ_INASISTENCIAS
CREATE INDEX ACJJ_INAS_FK_CALENDARIOS_IDX 
    ON ACJJ_INASISTENCIAS (cal_fecha, cal_id_grupo, cal_id_club);

-- 21. ACCJ_OBRAS_TEATRALES
CREATE INDEX ACCJ_OBRAS_FK_LIBROS_IDX 
    ON ACCJ_OBRAS_TEATRALES (isbn_libro);

-- 22. ACJJ_ELENCOS
CREATE INDEX ACJJ_ELE_FK_LECTORES_IDX 
    ON ACJJ_ELENCOS (id_actor);

-- 24. ACCJ_MEJORES_ACTORES
CREATE INDEX ACCJ_MA_FK_ELENCOS_IDX 
    ON ACCJ_MEJORES_ACTORES (id_actor, id_obra_el, isbn_el, id_club_el);

CREATE INDEX ACCJ_MA_FK_PRESENTACIONES_IDX 
    ON ACCJ_MEJORES_ACTORES (fecha_pres, id_obra_pres, isbn_pres, id_club_pres);

--INDICES ADICIONALES

CREATE INDEX ACCJ_LIB_TITULO_IDX
    ON ACJJ_LIBROS (titulo);

CREATE INDEX ACJJ_LEC_NOMBRE_COMP_IDX 
    ON ACJJ_LECTORES (p_apellido, s_apellido, p_nombre);

CREATE INDEX ACJJ_REP_NOMBRE_COMP_IDX 
    ON ACJJ_REPRESENTANTES (p_apellido, s_apellido, p_nombre);

--
--CREATES DE SECUENCIAS
--

-- 1. Secuencia para ACJJ_PAISES.id_pais
CREATE SEQUENCE ACJJ_PAISES_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999;

-- 2. Secuencia para ACJJ_AUTORES.id_autor
CREATE SEQUENCE ACJJ_AUTORES_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999;

-- 3. Secuencia para ACJJ_INSTITUCIONES.id_institucion
CREATE SEQUENCE ACJJ_INSTITUCIONES_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999;

-- 4. Secuencia para ACJJ_REPRESENTANTES.id_rep
CREATE SEQUENCE ACJJ_REPRESENTANTES_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999;

-- 5. Secuencia para ACJJ_IDIOMAS.id_idioma
CREATE SEQUENCE ACJJ_IDIOMAS_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999;

-- 9. Secuencia para ACJJ_LECTORES.id_lector
CREATE SEQUENCE ACJJ_LECTORES_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999;

-- 10. Secuencia para ACJJ_TELEFONOS.id_tel
CREATE SEQUENCE ACJJ_TELEFONOS_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999;

-- 12. Secuencia para ACJJ_CLUBES_DE_LECTURA.id_club
CREATE SEQUENCE ACJJ_CLUBES_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999;

-- 14. Secuencia para ACJJ_IDIOM_CLUB_LEC.id 
CREATE SEQUENCE ACJJ_IDIOM_CLUB_LEC_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999;