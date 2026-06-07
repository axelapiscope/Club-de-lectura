-- =========================================================
-- PROYECTO: CLUBES DE LECTURA  |  Grupo 7  NRC=25758
-- Apiscope, Axel. Bonilla, Javier. Moschella, Carmelo CI30861195. Perdomo, Javier. 
-- Script DDL - Estructura completa de tablas (24 entidades)
-- iniciales de los integrantes para los objetos: AJJC_
-- MBD: Oracle Database Free 23c
-- =========================================================
-- BLOQUE 1: IDIOMA Y GEOGRAFIAA 
-- =========================================================

-- 1. AJJC_PAIS
CREATE TABLE AJJC_PAIS (
    id_pais         NUMBER,
    nombre_pais     VARCHAR2(80)  NOT NULL,
    codigo_moneda   VARCHAR2(3)   NOT NULL,
    nacionalidad    VARCHAR2(60)  NOT NULL,
    CONSTRAINT AJJC_PK_PAIS         PRIMARY KEY (id_pais),
    CONSTRAINT AJJC_UQ_PAIS_NOMBRE  UNIQUE (nombre_pais)
);

-- 2. AJJC_CIUDAD
CREATE TABLE AJJC_CIUDAD (
    id_ciudad       NUMBER,
    id_pais         NUMBER       NOT NULL,
    nombre_ciudad   VARCHAR2(80) NOT NULL,
    CONSTRAINT AJJC_PK_CIUDAD      PRIMARY KEY (id_ciudad),
    CONSTRAINT AJJC_FK_CIUDAD_PAIS FOREIGN KEY (id_pais) REFERENCES AJJC_PAIS(id_pais)
);

-- 3. AJJC_INSTITUCION
CREATE TABLE AJJC_INSTITUCION (
    id_institucion      NUMBER,
    nombre_institucion  VARCHAR2(120) NOT NULL,
    tipo_institucion    VARCHAR2(40)  NOT NULL,
    CONSTRAINT AJJC_PK_INST      PRIMARY KEY (id_institucion),
    CONSTRAINT AJJC_CHECK_TIPO_INST CHECK (tipo_institucion IN
        ('biblioteca','universidad','colegio','otro'))
);

-- 4. AJJC_IDIOMA
CREATE TABLE AJJC_IDIOMA (
    id_idioma       NUMBER,
    nombre_idioma   VARCHAR2(40) NOT NULL,
    CONSTRAINT AJJC_PK_IDIOMA      PRIMARY KEY (id_idioma),
    CONSTRAINT AJJC_UQ_IDIOMA_NOMB UNIQUE (nombre_idioma)
);


-- =========================================================
-- BLOQUE 2: LIBROS Y AUTORES
-- =========================================================

-- 5. AJJC_LIBRO
CREATE TABLE AJJC_LIBRO (
    isbn                VARCHAR2(20),
    id_pais             NUMBER        NOT NULL,
    id_idioma           NUMBER        NOT NULL,
    titulo              VARCHAR2(200) NOT NULL,
    titulo_original     VARCHAR2(200),
    anio_publicacion    NUMBER(4)     NOT NULL,
    cantidad_paginas    NUMBER        NOT NULL,
    sinopsis            varchar2(4000)         NOT NULL,
    tipo_narrativa      VARCHAR2(60)  NOT NULL,
    temas_resumen       VARCHAR2(500) NOT NULL,
    CONSTRAINT AJJC_PK_LIBRO       PRIMARY KEY (isbn),
    CONSTRAINT AJJC_FK_LIBRO_PAIS  FOREIGN KEY (id_pais)   REFERENCES AJJC_PAIS(id_pais),
    CONSTRAINT AJJC_FK_LIBRO_IDIOM FOREIGN KEY (id_idioma) REFERENCES AJJC_IDIOMA(id_idioma)
);

-- 6. AJJC_AUTOR
CREATE TABLE AJJC_AUTOR (
    id_autor            NUMBER,
    nombre              VARCHAR2(80),
    apellido            VARCHAR2(80),
    nombre_artistico    VARCHAR2(120),
    CONSTRAINT AJJC_PK_AUTOR          PRIMARY KEY (id_autor),
    CONSTRAINT AJJC_CHK_AUTOR_NOMBRE  CHECK ((nombre IS NOT NULL AND apellido IS NOT NULL) OR (nombre_artistico IS NOT NULL))
);

-- 7. AJJC_LIBRO_AUTOR (interseccion N:M)
CREATE TABLE AJJC_LIBRO_AUTOR (
    isbn        VARCHAR2(20),
    id_autor    NUMBER,
    CONSTRAINT AJJC_PK_LIBRO_AUTOR PRIMARY KEY (isbn, id_autor),
    CONSTRAINT AJJC_FK_LA_LIBRO    FOREIGN KEY (isbn)     REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT AJJC_FK_LA_AUTOR    FOREIGN KEY (id_autor) REFERENCES AJJC_AUTOR(id_autor)
);

-- 8. AJJC_LIBRO_SECUENCIA (orden de lectura recomendado, auto-referencia)
CREATE TABLE AJJC_LIBRO_SECUENCIA (
    isbn            VARCHAR2(20),
    isbn_siguiente  VARCHAR2(20),
    orden_lectura   NUMBER NOT NULL,
    CONSTRAINT AJJC_PK_LIBRO_SEC    PRIMARY KEY (isbn, isbn_siguiente),
    CONSTRAINT AJJC_FK_LS_LIBRO     FOREIGN KEY (isbn)           REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT AJJC_FK_LS_SIGUIENTE FOREIGN KEY (isbn_siguiente) REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT AJJC_CHECK_LS_DISTINTO CHECK (isbn <> isbn_siguiente)
);


-- =========================================================
-- BLOQUE 3: CLUBES Y GRUPOS
-- =========================================================

-- 9. AJJC_CLUB_DE_LECTURA
CREATE TABLE AJJC_CLUB_DE_LECTURA (
    id_club             NUMBER,
    id_ciudad           NUMBER        NOT NULL,
    id_institucion      NUMBER,
    nombre_club         VARCHAR2(120) NOT NULL,
    direccion_club      VARCHAR2(200) NOT NULL,
    email_club          VARCHAR2(120) NOT NULL,
    codpostal_club      VARCHAR2(15)  NOT NULL,
    obtiene_membresia   CHAR(1)       NOT NULL,
    CONSTRAINT AJJC_PK_CLUB        PRIMARY KEY (id_club),
    CONSTRAINT AJJC_FK_CLUB_CIUDAD FOREIGN KEY (id_ciudad)      REFERENCES AJJC_CIUDAD(id_ciudad),
    CONSTRAINT AJJC_FK_CLUB_INST   FOREIGN KEY (id_institucion) REFERENCES AJJC_INSTITUCION(id_institucion),
    CONSTRAINT AJJC_UNIQ_CLUB_EMAIL  UNIQUE (email_club),
    CONSTRAINT AJJC_CHK_CLUB_MEMB  CHECK (obtiene_membresia IN ('S','N'))
);

-- 10. AJJC_CLUB_ASOCIADO (reflexiva N:M)
CREATE TABLE AJJC_CLUB_ASOCIADO (
    id_club_1   NUMBER,
    id_club_2   NUMBER,
    CONSTRAINT AJJC_PK_CLUB_ASOC    PRIMARY KEY (id_club_1, id_club_2),
    CONSTRAINT AJJC_FK_CA_CLUB1     FOREIGN KEY (id_club_1) REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT AJJC_FK_CA_CLUB2     FOREIGN KEY (id_club_2) REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT AJJC_CHK_CA_DISTINTO CHECK (id_club_1 <> id_club_2)
);

-- 11. AJJC_GRUPO_DE_LECTURA
CREATE TABLE AJJC_GRUPO_DE_LECTURA (
    id_grupo                NUMBER,
    id_club                 NUMBER       NOT NULL,
    tipo_grupo              VARCHAR2(10) NOT NULL,
    fecha_creacion          DATE         NOT NULL,
    dia_reunion             VARCHAR2(10) NOT NULL,
    hora_inicio_reunion     VARCHAR2(5)  NOT NULL,
    CONSTRAINT AJJC_PK_GRUPO      PRIMARY KEY (id_grupo),
    CONSTRAINT AJJC_FK_GRUPO_CLUB FOREIGN KEY (id_club) REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT AJJC_CHK_GRUPO_TIPO CHECK (tipo_grupo  IN ('infantil','juvenil','adulto')),
    CONSTRAINT AJJC_CHK_GRUPO_DIA  CHECK (dia_reunion IN ('Lunes','Martes','Miercoles','Jueves','Viernes'))
);

-- =========================================================
-- BLOQUE 4: MIEMBROS Y REPRESENTANTES
-- =========================================================
-- 12. AJJC_LECTOR
-- id_representante se agrega con ALTER TABLE despues por dependencia circular
CREATE TABLE AJJC_LECTOR (
    id_miembro          NUMBER,
    id_pais             NUMBER        NOT NULL,
    id_representante    NUMBER,
    doc_identidad       VARCHAR2(20)  NOT NULL,
    primer_nombre       VARCHAR2(60)  NOT NULL,
    segundo_nombre      VARCHAR2(60),
    primer_apellido     VARCHAR2(60)  NOT NULL,
    segundo_apellido    VARCHAR2(60),
    email               VARCHAR2(120) NOT NULL,
    fecha_nacimiento    DATE          NOT NULL,
    CONSTRAINT AJJC_PK_LECTOR      PRIMARY KEY (id_miembro),
    CONSTRAINT AJJC_FK_LECT_PAIS   FOREIGN KEY (id_pais) REFERENCES AJJC_PAIS(id_pais),
    CONSTRAINT AJJC_UQ_LECT_DOC    UNIQUE (doc_identidad),
    CONSTRAINT AJJC_UQ_LECT_EMAIL  UNIQUE (email)
);

-- 13. AJJC_REPRESENTANTE
CREATE TABLE AJJC_REPRESENTANTE (
    id_representante    NUMBER,
    id_miembro          NUMBER,
    doc_identidad       VARCHAR2(20)  NOT NULL,
    primer_nombre       VARCHAR2(60)  NOT NULL,
    segundo_nombre      VARCHAR2(60),
    primer_apellido     VARCHAR2(60)  NOT NULL,
    segundo_apellido    VARCHAR2(60), 
    email               VARCHAR2(120),
    CONSTRAINT AJJC_PK_REP      PRIMARY KEY (id_representante),
    CONSTRAINT AJJC_FK_REP_LECT FOREIGN KEY (id_miembro) REFERENCES AJJC_LECTOR(id_miembro),
    CONSTRAINT AJJC_UQ_REP_DOC  UNIQUE (doc_identidad)
);

-- FK circular: AJJC_LECTOR.id_representante -> AJJC_REPRESENTANTE
ALTER TABLE AJJC_LECTOR ADD CONSTRAINT AJJC_FK_LECT_REP
    FOREIGN KEY (id_representante) REFERENCES AJJC_REPRESENTANTE(id_representante);

-- 14. AJJC_TELEFONO (arco exclusivo LECTOR / REPRESENTANTE)
CREATE TABLE AJJC_TELEFONO (
    id_tlf              NUMBER,
    id_miembro          NUMBER,
    id_representante    NUMBER,
    codigo_pais         VARCHAR2(5)  NOT NULL,
    codigo_area         VARCHAR2(5)  NOT NULL,
    numero              VARCHAR2(15) NOT NULL,
    CONSTRAINT AJJC_PK_TELEFONO   PRIMARY KEY (id_tlf),
    CONSTRAINT AJJC_FK_TLF_LECT   FOREIGN KEY (id_miembro)      REFERENCES AJJC_LECTOR(id_miembro),
    CONSTRAINT AJJC_FK_TLF_REP    FOREIGN KEY (id_representante) REFERENCES AJJC_REPRESENTANTE(id_representante),
    CONSTRAINT AJJC_CHECK_TLF_ARCO  CHECK ((id_miembro IS NOT NULL AND id_representante IS NULL) OR (id_miembro IS NULL   
    AND id_representante IS NOT NULL))
);

-- 15. AJJC_MIEMBRO_IDIOMA (arco exclusivo LECTOR / CLUB)
CREATE TABLE AJJC_MIEMBRO_IDIOMA (
    id_miem_idio    NUMBER,
    id_idioma       NUMBER NOT NULL,
    id_miembro      NUMBER,
    id_club         NUMBER,
    CONSTRAINT AJJC_PK_MIEM_IDIO  PRIMARY KEY (id_miem_idio),
    CONSTRAINT AJJC_FK_MI_IDIOMA  FOREIGN KEY (id_idioma)  REFERENCES AJJC_IDIOMA(id_idioma),
    CONSTRAINT AJJC_FK_MI_LECTOR  FOREIGN KEY (id_miembro) REFERENCES AJJC_LECTOR(id_miembro),
    CONSTRAINT AJJC_FK_MI_CLUB    FOREIGN KEY (id_club)    REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT AJJC_CHK_MI_ARCO   CHECK ((id_miembro IS NOT NULL AND id_club IS NULL) OR (id_miembro IS NULL AND id_club IS NOT NULL))
);

-- 16. AJJC_MEMBRESIA
CREATE TABLE AJJC_MEMBRESIA (
    id_membresia    NUMBER,
    id_miembro      NUMBER       NOT NULL,
    id_club         NUMBER       NOT NULL,
    fecha_ingreso   DATE         NOT NULL,
    fecha_retiro    DATE,
    estatus         VARCHAR2(10) NOT NULL,
    motivo_retiro   VARCHAR2(20),
    CONSTRAINT AJJC_PK_MEMBRESIA    PRIMARY KEY (id_membresia),
    CONSTRAINT AJJC_FK_MEMB_LECTOR  FOREIGN KEY (id_miembro) REFERENCES AJJC_LECTOR(id_miembro),
    CONSTRAINT AJJC_FK_MEMB_CLUB    FOREIGN KEY (id_club)    REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT AJJC_CHK_MEMB_ESTAT  CHECK (estatus IN ('activo','inactivo')),
    CONSTRAINT AJJC_CHK_MEMB_MOTIV  CHECK (motivo_retiro IN ('voluntario','deuda','inasistencia','otro'))
);

-- 17. AJJC_PAGO
CREATE TABLE AJJC_PAGO (
    id_pago         NUMBER,
    id_membresia    NUMBER NOT NULL,
    fecha_pago      DATE   NOT NULL,
    CONSTRAINT AJJC_PK_PAGO        PRIMARY KEY (id_pago),
    CONSTRAINT AJJC_FK_PAGO_MEMB   FOREIGN KEY (id_membresia) REFERENCES AJJC_MEMBRESIA(id_membresia)
);

-- 18. AJJC_LIBRO_PREFERIDO
CREATE TABLE AJJC_LIBRO_PREFERIDO (
    id_miembro          NUMBER,
    isbn                VARCHAR2(20),
    orden_preferencia   NUMBER(1) NOT NULL,
    CONSTRAINT AJJC_PK_LIBRO_PREF   PRIMARY KEY (id_miembro, isbn),
    CONSTRAINT AJJC_FK_LP_LECTOR    FOREIGN KEY (id_miembro) REFERENCES AJJC_LECTOR(id_miembro),
    CONSTRAINT AJJC_FK_LP_LIBRO     FOREIGN KEY (isbn)       REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT AJJC_CHK_LP_ORDEN    CHECK (orden_preferencia BETWEEN 1 AND 3),
    CONSTRAINT AJJC_UQ_LP_ORDEN     UNIQUE (id_miembro, orden_preferencia)
);


-- =========================================================
-- BLOQUE 5: REUNIONES Y ANALISIS
-- =========================================================

-- 19. AJJC_LIBRO_ANALIZADO
CREATE TABLE AJJC_LIBRO_ANALIZADO (
    id_grupo    NUMBER,
    isbn        VARCHAR2(20),
    CONSTRAINT AJJC_PK_LIBRO_ANALIZ  PRIMARY KEY (id_grupo, isbn),
    CONSTRAINT AJJC_FK_LANAL_GRUPO FOREIGN KEY (id_grupo) REFERENCES AJJC_GRUPO_DE_LECTURA(id_grupo),
    CONSTRAINT AJJC_FK_LANAL_LIBRO FOREIGN KEY (isbn)     REFERENCES AJJC_LIBRO(isbn)
);
--- 20. GRupo_lector 
CREATE TABLE AJJC_GRUPO_LECTOR (
    id_membresia    NUMBER,
    id_grupo        NUMBER,
    fechai          DATE,
    fechaf          DATE,
    CONSTRAINT AJJC_PK_GLC       PRIMARY KEY (id_membresia, id_grupo, fechai),
    CONSTRAINT AJJC_FK_GLC_MEMB  FOREIGN KEY (id_membresia) REFERENCES AJJC_MEMBRESIA(id_membresia),
    CONSTRAINT AJJC_FK_GLC_GRUPO FOREIGN KEY (id_grupo)     REFERENCES AJJC_GRUPO_DE_LECTURA(id_grupo)
);
-- 21. AJJC_CALENDARIO_MES (PK compuesta)
CREATE TABLE AJJC_CALENDARIO_MES (
    id_grupo            NUMBER,
    isbn                VARCHAR2(20),
    fecha_reunion       DATE,
    id_moderador        NUMBER,
    ultima_reunion      CHAR(1),
    fue_realizada       CHAR(1),
    conclusiones_libro  VARCHAR2(2000),
    valoracion_libro    NUMBER(1),
    CONSTRAINT AJJC_PK_CALENDARIO  PRIMARY KEY (id_grupo, isbn, fecha_reunion),
    CONSTRAINT AJJC_FK_CAL_GRUPO   FOREIGN KEY (id_grupo)     REFERENCES AJJC_GRUPO_DE_LECTURA(id_grupo),
    CONSTRAINT AJJC_FK_CAL_LIBRO   FOREIGN KEY (isbn)         REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT AJJC_FK_CAL_MODER   FOREIGN KEY (id_moderador) REFERENCES AJJC_LECTOR(id_miembro),
    CONSTRAINT AJJC_CHK_CAL_ULTIMA CHECK (ultima_reunion   IN ('S','N')),
    CONSTRAINT AJJC_CHK_CAL_REALIZ CHECK (fue_realizada    IN ('S','N')),
    CONSTRAINT AJJC_CHK_CAL_VALOR  CHECK (valoracion_libro BETWEEN 1 AND 5)
);

-- 22. AJJC_INASISTENCIA (FK compuesta a CALENDARIO_MES + LECTOR)
CREATE TABLE AJJC_INASISTENCIA (
    id_membresia    NUMBER,
    id_grupo        NUMBER,
    fechai          DATE,
    isbn            VARCHAR2(20),
    fecha_reunion   DATE,
    CONSTRAINT AJJC_PK_INASISTENCIA PRIMARY KEY (id_membresia, id_grupo, fechai, isbn, fecha_reunion),
    CONSTRAINT AJJC_FK_INAS_GLC  FOREIGN KEY (id_membresia, id_grupo, fechai)
        REFERENCES AJJC_GRUPO_LECTOR(id_membresia, id_grupo, fechai),
    CONSTRAINT AJJC_FK_INAS_CAL  FOREIGN KEY (id_grupo, isbn, fecha_reunion)
        REFERENCES AJJC_CALENDARIO_MES(id_grupo, isbn, fecha_reunion)
);


-- =========================================================
-- BLOQUE 6: OBRAS TEATRALES
-- =========================================================

-- 23. AJJC_OBRA_TEATRAL
CREATE TABLE AJJC_OBRA_TEATRAL (
    id_obra         NUMBER,
    id_club         NUMBER       NOT NULL,
    isbn            VARCHAR2(20) NOT NULL,
    estatus         VARCHAR2(10) NOT NULL,
    costo_entrada   NUMBER(8,2)  NOT NULL,
    CONSTRAINT AJJC_PK_OBRA         PRIMARY KEY (id_obra),
    CONSTRAINT AJJC_FK_OBRA_CLUB    FOREIGN KEY (id_club) REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT AJJC_FK_OBRA_LIBRO   FOREIGN KEY (isbn)    REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT AJJC_CHK_OBRA_ESTAT  CHECK (estatus IN ('activa','inactiva'))
);

-- 24. AJJC_PRESENTACION (PK compuesta id_obra + fecha)
CREATE TABLE AJJC_PRESENTACION (
    id_obra                 NUMBER,
    fecha                   DATE,
    cant_entradas_vendidas  NUMBER    NOT NULL,
    estrellas_obtenidas     NUMBER(1) NOT NULL,
    CONSTRAINT AJJC_PK_PRESENTACION   PRIMARY KEY (id_obra, fecha),
    CONSTRAINT AJJC_FK_PRES_OBRA      FOREIGN KEY (id_obra) REFERENCES AJJC_OBRA_TEATRAL(id_obra),
    CONSTRAINT AJJC_CHK_PRES_ENTRAD   CHECK (cant_entradas_vendidas >= 0),
    CONSTRAINT AJJC_CHK_PRES_ESTREL   CHECK (estrellas_obtenidas BETWEEN 0 AND 5)
);

-- 25. AJJC_ELENCO (interseccion N:M obra-actor)
CREATE TABLE AJJC_ELENCO (
    id_obra     NUMBER,
    id_miembro  NUMBER,
    CONSTRAINT AJJC_PK_ELENCO       PRIMARY KEY (id_obra, id_miembro),
    CONSTRAINT AJJC_FK_ELENCO_OBRA  FOREIGN KEY (id_obra)    REFERENCES AJJC_OBRA_TEATRAL(id_obra),
    CONSTRAINT AJJC_FK_ELENCO_LECT  FOREIGN KEY (id_miembro) REFERENCES AJJC_LECTOR(id_miembro)
);

-- 26. AJJC_MEJOR_ACTOR (FK compuesta a PRESENTACION + ELENCO)
CREATE TABLE AJJC_MEJOR_ACTOR (
    id_obra     NUMBER,
    fecha       DATE,
    id_miembro  NUMBER,
    CONSTRAINT AJJC_PK_MEJOR_ACTOR  PRIMARY KEY (id_obra, fecha, id_miembro),
    CONSTRAINT AJJC_FK_MA_PRES      FOREIGN KEY (id_obra, fecha)
        REFERENCES AJJC_PRESENTACION(id_obra, fecha),
    CONSTRAINT AJJC_FK_MA_ELENCO    FOREIGN KEY (id_obra, id_miembro)
        REFERENCES AJJC_ELENCO(id_obra, id_miembro)
);

CREATE SEQUENCE AJJC_SEQ_PAIS          START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_CIUDAD        START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_INSTITUCION   START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_IDIOMA        START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_AUTOR         START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_CLUB          START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_GRUPO         START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_LECTOR        START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_REPRESENTANTE START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_TELEFONO      START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_MIEM_IDIO     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_MEMBRESIA     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_PAGO          START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE AJJC_SEQ_OBRA          START WITH 1 INCREMENT BY 1 NOCACHE;