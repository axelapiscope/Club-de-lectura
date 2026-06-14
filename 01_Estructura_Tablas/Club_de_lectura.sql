
-- ================================================================
-- SCRIPT COMPLETO DE CREACIÓN DE TABLAS
-- Proyecto: Clubes de Lectura
-- Grupo 7 | NRC=25758 | Axel, Javier, José, Carmelo
-- SGBD: Oracle SQL Developer
-- Prefijo: AJJC_
-- ================================================================
-- ORDEN DE CREACION (respeta dependencias FK):
--  1. PAIS
--  2. CIUDAD
--  3. INSTITUCION
--  4. IDIOMA
--  5. LIBRO
--  6. AUTOR
--  7. LIBRO_AUTOR
--  8. REPRESENTANTE (sin FK a MIEMBRO aun)
--  9. MIEMBRO
-- 10. REPRESENTANTE (ALTER para agregar FK a MIEMBRO)
-- 11. TELEFONO
-- 12. MIEMBRO_IDIOMA
-- 13. CLUB_DE_LECTURA
-- 14. CLUB_ASOCIADO
-- 15. GRUPO_DE_LECTURA
-- 16. MEMBRESIA
-- 17. LIBRO_PREFERIDO
-- 18. LIBRO_ANALIZADO
-- 19. CALENDARIO_MES
-- 20. INASISTENCIA
-- 21. PAGO
-- 22. OBRA_TEATRAL
-- 23. PRESENTACION
-- 24. ELENCO
-- 25. MEJOR_ACTOR
-- ================================================================
 
 
-- ----------------------------------------------------------------
-- 1. AJJC_PAIS
-- Catalogo de paises. Usado para nacionalidad, ubicacion y moneda.
-- codigo_moneda sigue ISO 4217 (USD, EUR, VES, etc.)
-- ----------------------------------------------------------------
CREATE TABLE AJJC_PAIS (
    id_pais         NUMBER          CONSTRAINT pk_pais PRIMARY KEY,
    nombre_pais     VARCHAR2(80)    NOT NULL,
    codigo_moneda   VARCHAR2(3)     NOT NULL,
    nacionalidad    VARCHAR2(60)    NOT NULL,
    CONSTRAINT uq_pais_moneda       UNIQUE (codigo_moneda),
    CONSTRAINT uq_pais_nombre       UNIQUE (nombre_pais)
);
 
 
-- ----------------------------------------------------------------
-- 2. AJJC_CIUDAD
-- Ciudades vinculadas a un pais.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_CIUDAD (
    id_ciudad       NUMBER          CONSTRAINT pk_ciudad PRIMARY KEY,
    id_pais         NUMBER          NOT NULL,
    nombre_ciudad   VARCHAR2(80)    NOT NULL,
    CONSTRAINT fk_ciudad_pais FOREIGN KEY (id_pais)
        REFERENCES AJJC_PAIS(id_pais)
);
 
 
-- ----------------------------------------------------------------
-- 3. AJJC_INSTITUCION
-- Instituciones a las que puede estar adscrito un club.
-- Clubs dependientes de institucion NO cobran membresia.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_INSTITUCION (
    id_institucion      NUMBER          CONSTRAINT pk_institucion PRIMARY KEY,
    nombre_institucion  VARCHAR2(120)   NOT NULL,
    tipo_institucion    VARCHAR2(40)    NOT NULL,
    CONSTRAINT chk_inst_tipo CHECK (
        tipo_institucion IN ('biblioteca','universidad','colegio','otro')
    )
);
 
 
-- ----------------------------------------------------------------
-- 4. AJJC_IDIOMA
-- Catalogo de idiomas.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_IDIOMA (
    id_idioma       NUMBER          CONSTRAINT pk_idioma PRIMARY KEY,
    nombre_idioma   VARCHAR2(40)    NOT NULL,
    CONSTRAINT uq_idioma_nombre UNIQUE (nombre_idioma)
);
 
 
-- ----------------------------------------------------------------
-- 5. AJJC_LIBRO
-- Catalogo global de libros.
-- id_pais: pais de la 1ra edicion.
-- id_libro_sig / id_libro_prev: auto-referencias para orden de
--   lectura recomendado (series como Harry Potter, etc).
--   Son NULL si el libro no forma parte de una serie.
-- titulo_original es NULL si fue escrito en el idioma del club.
-- Trigger externo evita ciclos en la cadena sig/prev.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_LIBRO (
    isbn                VARCHAR2(20)    CONSTRAINT pk_libro PRIMARY KEY,
    id_pais             NUMBER          NOT NULL,
    id_libro_sig        VARCHAR2(20)    NULL,
    id_libro_prev       VARCHAR2(20)    NULL,
    titulo              VARCHAR2(200)   NOT NULL,
    titulo_original     VARCHAR2(200)   NULL,
    anio_publi          NUMBER(4)       NOT NULL,
    cant_paginas        NUMBER          NOT NULL,
    sinopsis            CLOB            NOT NULL,
    tipo_narrativa      VARCHAR2(60)    NOT NULL,
    temas_resumen       VARCHAR2(500)   NOT NULL,
    CONSTRAINT fk_libro_pais    FOREIGN KEY (id_pais)
        REFERENCES AJJC_PAIS(id_pais),
    CONSTRAINT fk_libro_sig     FOREIGN KEY (id_libro_sig)
        REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT fk_libro_prev    FOREIGN KEY (id_libro_prev)
        REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT chk_libro_anio   CHECK (anio_publi > 0),
    CONSTRAINT chk_libro_pags   CHECK (cant_paginas > 0)
);
 
 
-- ----------------------------------------------------------------
-- 6. AJJC_AUTOR
-- Catalogo de autores.
-- Al menos uno de los tres campos de nombre debe tener valor.
-- Eso se valida via trigger (no implementable con CHECK simple).
-- ----------------------------------------------------------------
CREATE TABLE AJJC_AUTOR (
    id_autor        NUMBER          CONSTRAINT pk_autor PRIMARY KEY,
    nombre          VARCHAR2(80)    NULL,
    apellido        VARCHAR2(80)    NULL,
    nombre_artistico VARCHAR2(120)  NULL
    -- TRIGGER: valida que al menos uno de los tres campos no sea NULL
);
 
 
-- ----------------------------------------------------------------
-- 7. AJJC_LIBRO_AUTOR
-- Interseccion N:M entre LIBRO y AUTOR.
-- Un libro puede tener varios autores y un autor varios libros.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_LIBRO_AUTOR (
    isbn        VARCHAR2(20)    NOT NULL,
    id_autor    NUMBER          NOT NULL,
    CONSTRAINT pk_libautor PRIMARY KEY (isbn, id_autor),
    CONSTRAINT fk_libautor_libro  FOREIGN KEY (isbn)
        REFERENCES AJJC_LIBRO(isbn),
    CONSTRAINT fk_libautor_autor  FOREIGN KEY (id_autor)
        REFERENCES AJJC_AUTOR(id_autor)
);
 
 
-- ----------------------------------------------------------------
-- 8. AJJC_REPRESENTANTE
-- Representantes legales de miembros menores de 18 anios.
-- id_miembro es NULL si el representante no es miembro del club.
-- FK a MIEMBRO se agrega con ALTER despues de crear MIEMBRO
--   (dependencia circular: MIEMBRO -> REPRESENTANTE -> MIEMBRO).
-- ----------------------------------------------------------------
CREATE TABLE AJJC_REPRESENTANTE (
    id_representante    NUMBER          CONSTRAINT pk_representante PRIMARY KEY,
    id_miembro          NUMBER          NULL,
    doc_identidad       VARCHAR2(20)    NOT NULL,
    primer_nombre       VARCHAR2(60)    NOT NULL,
    segundo_nombre      VARCHAR2(60)    NULL,
    primer_apellido     VARCHAR2(60)    NOT NULL,
    segundo_apellido    VARCHAR2(60)    NULL,
    email               VARCHAR2(120)   NULL,
    CONSTRAINT uq_rep_doc   UNIQUE (doc_identidad)
    -- FK a AJJC_MIEMBRO se agrega con ALTER TABLE mas abajo
);
 
 
-- ----------------------------------------------------------------
-- 9. AJJC_MIEMBRO
-- Datos personales de cada lector registrado.
-- id_pais: nacionalidad del miembro.
-- id_representante: obligatorio si el miembro es menor de 18.
--   Trigger valida esa regla.
-- doc_identidad y email son UNIQUE a nivel global.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_MIEMBRO (
    id_miembro          NUMBER          CONSTRAINT pk_miembro PRIMARY KEY,
    id_pais             NUMBER          NOT NULL,
    id_representante    NUMBER          NULL,
    doc_identidad       VARCHAR2(20)    NOT NULL,
    primer_nombre       VARCHAR2(60)    NOT NULL,
    segundo_nombre      VARCHAR2(60)    NULL,
    primer_apellido     VARCHAR2(60)    NOT NULL,
    segundo_apellido    VARCHAR2(60)    NULL,
    email               VARCHAR2(120)   NOT NULL,
    fecha_nacimiento    DATE            NOT NULL,
    CONSTRAINT uq_miem_doc      UNIQUE (doc_identidad),
    CONSTRAINT uq_miem_email    UNIQUE (email),
    CONSTRAINT fk_miem_pais     FOREIGN KEY (id_pais)
        REFERENCES AJJC_PAIS(id_pais),
    CONSTRAINT fk_miem_rep      FOREIGN KEY (id_representante)
        REFERENCES AJJC_REPRESENTANTE(id_representante)
    -- TRIGGER: valida que menores de 18 tengan id_representante NOT NULL
);
 
 
-- ----------------------------------------------------------------
-- 10. ALTER REPRESENTANTE: agrega FK a MIEMBRO
-- Se hace aqui porque MIEMBRO ya existe en este punto.
-- ----------------------------------------------------------------
ALTER TABLE AJJC_REPRESENTANTE
    ADD CONSTRAINT fk_rep_miembro FOREIGN KEY (id_miembro)
        REFERENCES AJJC_MIEMBRO(id_miembro);
 
 
-- ----------------------------------------------------------------
-- 11. AJJC_TELEFONO
-- Telefonos de miembros y representantes.
-- Arco exclusivo: exactamente UNO de id_miembro o id_representante
--   debe estar lleno, nunca los dos ni ninguno.
--   Eso se implementa via trigger.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_TELEFONO (
    id_tlf          NUMBER          CONSTRAINT pk_telefono PRIMARY KEY,
    id_miembro      NUMBER          NULL,
    id_representante NUMBER         NULL,
    codigo_pais     VARCHAR2(5)     NOT NULL,
    codigo_area     VARCHAR2(5)     NOT NULL,
    numero          VARCHAR2(15)    NOT NULL,
    CONSTRAINT fk_tel_miembro   FOREIGN KEY (id_miembro)
        REFERENCES AJJC_MIEMBRO(id_miembro),
    CONSTRAINT fk_tel_rep       FOREIGN KEY (id_representante)
        REFERENCES AJJC_REPRESENTANTE(id_representante)
    -- TRIGGER: valida arco exclusivo (exactamente uno de los dos FK)
);
 
 
-- ----------------------------------------------------------------
-- 12. AJJC_MIEMBRO_IDIOMA
-- Relaciona IDIOMA con un MIEMBRO o un CLUB (arco exclusivo).
-- Nunca puede tener los dos a la vez ni ninguno.
-- Trigger implementa el arco exclusivo.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_MIEMBRO_IDIOMA (
    id_miem_idio    NUMBER  CONSTRAINT pk_miem_idioma PRIMARY KEY,
    id_idioma       NUMBER  NOT NULL,
    id_miembro      NUMBER  NULL,
    id_club         NUMBER  NULL,
    CONSTRAINT fk_mi_idioma FOREIGN KEY (id_idioma)
        REFERENCES AJJC_IDIOMA(id_idioma),
    CONSTRAINT fk_mi_miembro FOREIGN KEY (id_miembro)
        REFERENCES AJJC_MIEMBRO(id_miembro)
    -- FK a CLUB_DE_LECTURA se agrega con ALTER despues de crear CLUB
    -- TRIGGER: valida arco exclusivo
);
 
 
-- ----------------------------------------------------------------
-- 13. AJJC_CLUB_DE_LECTURA
-- Entidad principal del sistema.
-- id_institucion NULL: club independiente (cobra membresia).
-- obtiene_membresia='S': cobra $100 USD anuales.
-- obtiene_membresia='N': club dependiente de institucion.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_CLUB_DE_LECTURA (
    id_club             NUMBER          CONSTRAINT pk_club PRIMARY KEY,
    id_ciudad           NUMBER          NOT NULL,
    id_institucion      NUMBER          NULL,
    nombre_club         VARCHAR2(120)   NOT NULL,
    direccion_club      VARCHAR2(200)   NOT NULL,
    email_club          VARCHAR2(120)   NOT NULL,
    codpostal_club      VARCHAR2(15)    NOT NULL,
    obtiene_membresia   CHAR(1)         NOT NULL,
    CONSTRAINT uq_club_email        UNIQUE (email_club),
    CONSTRAINT chk_club_membresia   CHECK (obtiene_membresia IN ('S','N')),
    CONSTRAINT fk_club_ciudad       FOREIGN KEY (id_ciudad)
        REFERENCES AJJC_CIUDAD(id_ciudad),
    CONSTRAINT fk_club_institucion  FOREIGN KEY (id_institucion)
        REFERENCES AJJC_INSTITUCION(id_institucion)
);
 
 
-- ----------------------------------------------------------------
-- ALTER MIEMBRO_IDIOMA: agrega FK a CLUB_DE_LECTURA
-- ----------------------------------------------------------------
ALTER TABLE AJJC_MIEMBRO_IDIOMA
    ADD CONSTRAINT fk_mi_club FOREIGN KEY (id_club)
        REFERENCES AJJC_CLUB_DE_LECTURA(id_club);
 
 
-- ----------------------------------------------------------------
-- 14. AJJC_CLUB_ASOCIADO
-- Asociacion reflexiva entre clubes para intercambio cultural.
-- Trigger valida que id_club_1 != id_club_2.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_CLUB_ASOCIADO (
    id_club_1   NUMBER  NOT NULL,
    id_club_2   NUMBER  NOT NULL,
    CONSTRAINT pk_club_asociado PRIMARY KEY (id_club_1, id_club_2),
    CONSTRAINT fk_ca_club1  FOREIGN KEY (id_club_1)
        REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT fk_ca_club2  FOREIGN KEY (id_club_2)
        REFERENCES AJJC_CLUB_DE_LECTURA(id_club)
    -- TRIGGER: valida id_club_1 != id_club_2
);
 
 
-- ----------------------------------------------------------------
-- 15. AJJC_GRUPO_DE_LECTURA
-- Grupos dentro de cada club. Tipos: infantil, juvenil, adulto.
-- dia_reunion: L, M, X, J, V (no fines de semana).
-- hora_inicio: entre 17:00 y 19:00 (enunciado).
-- Trigger maneja el split automatico cuando se supera el maximo.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_GRUPO_DE_LECTURA (
    id_grupo            NUMBER          CONSTRAINT pk_grupo PRIMARY KEY,
    id_club             NUMBER          NOT NULL,
    tipo_grupo          VARCHAR2(10)    NOT NULL,
    fecha_creacion      DATE            NOT NULL,
    dia_reunion         VARCHAR2(10)    NOT NULL,
    hora_inicio_reunion VARCHAR2(5)     NOT NULL,
    CONSTRAINT chk_grupo_tipo   CHECK (tipo_grupo IN ('infantil','juvenil','adulto')),
    CONSTRAINT chk_grupo_dia    CHECK (dia_reunion IN ('L','M','X','J','V')),
    CONSTRAINT fk_grupo_club    FOREIGN KEY (id_club)
        REFERENCES AJJC_CLUB_DE_LECTURA(id_club)
    -- TRIGGER: valida hora entre 17:00 y 19:00
    -- TRIGGER: valida tamanio segun tipo y ejecuta split
);
 
 
-- ----------------------------------------------------------------
-- 16. AJJC_MEMBRESIA
-- Historico de pertenencia de un miembro a un grupo.
-- Una fila por cada afiliacion (incluye retiros y reingresos).
-- motivo_retiro solo aplica cuando estatus='inactivo'.
-- Trigger valida que un miembro no este activo en mas de un club.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_MEMBRESIA (
    id_membresia    NUMBER          CONSTRAINT pk_membresia PRIMARY KEY,
    id_miembro      NUMBER          NOT NULL,
    id_grupo        NUMBER          NOT NULL,
    fecha_ingreso   DATE            NOT NULL,
    fecha_retiro    DATE            NULL,
    estatus         VARCHAR2(10)    NOT NULL,
    motivo_retiro   VARCHAR2(20)    NULL,
    CONSTRAINT chk_mem_estatus  CHECK (estatus IN ('activo','inactivo')),
    CONSTRAINT chk_mem_motivo   CHECK (
        motivo_retiro IN ('voluntario','deuda','inasistencia','otro')
        OR motivo_retiro IS NULL
    ),
    CONSTRAINT fk_mem_miembro   FOREIGN KEY (id_miembro)
        REFERENCES AJJC_MIEMBRO(id_miembro),
    CONSTRAINT fk_mem_grupo     FOREIGN KEY (id_grupo)
        REFERENCES AJJC_GRUPO_DE_LECTURA(id_grupo)
    -- TRIGGER: valida que el miembro no este activo en mas de un club
    -- TRIGGER: renueva automaticamente la membresia al cumplir 1 anio
);
 
 
-- ----------------------------------------------------------------
-- 17. AJJC_LIBRO_PREFERIDO
-- Los 3 libros preferidos de cada miembro al inscribirse.
-- orden_preferencia: 1, 2 o 3 (unico por miembro).
-- Trigger valida exactamente 3 preferencias por miembro.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_LIBRO_PREFERIDO (
    id_miembro          NUMBER      NOT NULL,
    isbn                VARCHAR2(20) NOT NULL,
    orden_preferencia   NUMBER(1)   NOT NULL,
    CONSTRAINT pk_libro_preferido PRIMARY KEY (id_miembro, isbn, orden_preferencia),
    CONSTRAINT chk_lp_orden CHECK (orden_preferencia IN (1,2,3)),
    CONSTRAINT fk_lp_miembro    FOREIGN KEY (id_miembro)
        REFERENCES AJJC_MIEMBRO(id_miembro),
    CONSTRAINT fk_lp_libro      FOREIGN KEY (isbn)
        REFERENCES AJJC_LIBRO(isbn)
    -- TRIGGER: valida exactamente 3 preferencias por miembro
    -- TRIGGER: valida orden unico por miembro
);
 
 
-- ----------------------------------------------------------------
-- 18. AJJC_LIBRO_ANALIZADO
-- Libros que cada grupo ha analizado con su valoracion final.
-- valoracion y conclusiones se llenan al CERRAR el analisis.
-- Trigger valida que no se agregue un nuevo libro mientras se
--   este discutiendo uno (enunciado: max 3 reuniones por libro).
-- ----------------------------------------------------------------
CREATE TABLE AJJC_LIBRO_ANALIZADO (
    id_grupo        NUMBER          NOT NULL,
    isbn            VARCHAR2(20)    NOT NULL,
    valoracion      NUMBER(1)       NULL,
    conclusiones    VARCHAR2(2000)  NULL,
    CONSTRAINT pk_libanali PRIMARY KEY (id_grupo, isbn),
    CONSTRAINT chk_libanali_val CHECK (valoracion BETWEEN 1 AND 5),
    CONSTRAINT fk_libanali_grupo  FOREIGN KEY (id_grupo)
        REFERENCES AJJC_GRUPO_DE_LECTURA(id_grupo),
    CONSTRAINT fk_libanali_libro  FOREIGN KEY (isbn)
        REFERENCES AJJC_LIBRO(isbn)
);
 
 
-- ----------------------------------------------------------------
-- 19. AJJC_CALENDARIO_MES
-- Calendario mensual de reuniones por grupo.
-- PK compuesta (id_grupo, fechai): cada grupo puede tener
--   su propia reunion en cualquier fecha, incluso coincidiendo
--   con otro grupo.
-- fechaf es NULL hasta que la reunion se cierra.
-- Trigger valida que fechai caiga en dia_reunion del grupo.
--
-- DECISION: La PK es (id_grupo, fechai), NO incluye id_membresia.
-- Una reunion pertenece al grupo, no a un miembro individual.
-- La membresia aparece en INASISTENCIA para registrar ausentes.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_CALENDARIO_MES (
    id_grupo    NUMBER  NOT NULL,
    fechai      DATE    NOT NULL,
    fechaf      DATE    NULL,
    CONSTRAINT pk_calendario PRIMARY KEY (id_grupo, fechai),
    CONSTRAINT fk_cal_grupo FOREIGN KEY (id_grupo)
        REFERENCES AJJC_GRUPO_DE_LECTURA(id_grupo)
    -- TRIGGER: valida que fechai sea dia_reunion del grupo
    -- TRIGGER: valida franja horaria 17:00-19:00
);
 
 
-- ----------------------------------------------------------------
-- 20. AJJC_INASISTENCIA
-- Registra SOLO los miembros que NO asistieron a una reunion.
-- Los asistentes se derivan: miembros activos del grupo
--   menos los que aparecen en esta tabla.
-- PK hereda (id_grupo, fechai) de CALENDARIO_MES
--   mas id_membresia para saber quien falto.
-- NO se pone id_miembro directo porque ya se llega a traves
--   de MEMBRESIA (MEMBRESIA.id_miembro).
-- Trigger calcula acumulado de inasistencias por bimestre
--   y expulsa automaticamente si supera el 30%.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_INASISTENCIA (
    id_grupo        NUMBER  NOT NULL,
    fechai          DATE    NOT NULL,
    id_membresia    NUMBER  NOT NULL,
    CONSTRAINT pk_inasistencia PRIMARY KEY (id_grupo, fechai, id_membresia),
    CONSTRAINT fk_inas_calendario FOREIGN KEY (id_grupo, fechai)
        REFERENCES AJJC_CALENDARIO_MES(id_grupo, fechai),
    CONSTRAINT fk_inas_membresia  FOREIGN KEY (id_membresia)
        REFERENCES AJJC_MEMBRESIA(id_membresia)
    -- TRIGGER: calcula % inasistencia bimestral y expulsa si >30%
);
 
 
-- ----------------------------------------------------------------
-- 21. AJJC_PAGO
-- Registro de cada pago de membresia anual.
-- monto_pago se guarda en moneda local del pais del club.
-- La funcion Conversion_monetaria() convierte a USD para reportes.
-- monto_pago es necesario porque distintos paises tienen distinto
--   equivalente de $100 USD en moneda local.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_PAGO (
    id_pago         NUMBER          CONSTRAINT pk_pago PRIMARY KEY,
    id_membresia    NUMBER          NOT NULL,
    fecha_pago      DATE            NOT NULL,
    monto_pago      NUMBER(10,2)    NOT NULL,
    CONSTRAINT fk_pago_membresia FOREIGN KEY (id_membresia)
        REFERENCES AJJC_MEMBRESIA(id_membresia),
    CONSTRAINT chk_pago_monto CHECK (monto_pago > 0)
);
 
 
-- ----------------------------------------------------------------
-- 22. AJJC_OBRA_TEATRAL
-- Obras de teatro organizadas por un club basadas en un libro
--   que el club ya analizo previamente.
-- costo_entrada en moneda local; reportes usan Conversion_monetaria.
-- Trigger valida que el ISBN haya sido analizado por el club.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_OBRA_TEATRAL (
    id_obra         NUMBER          CONSTRAINT pk_obra PRIMARY KEY,
    id_club         NUMBER          NOT NULL,
    isbn            VARCHAR2(20)    NOT NULL,
    estatus         VARCHAR2(10)    NOT NULL,
    costo_entrada   NUMBER(8,2)     NOT NULL,
    CONSTRAINT chk_obra_estatus CHECK (estatus IN ('activa','inactiva')),
    CONSTRAINT chk_obra_costo   CHECK (costo_entrada >= 0),
    CONSTRAINT fk_obra_club     FOREIGN KEY (id_club)
        REFERENCES AJJC_CLUB_DE_LECTURA(id_club),
    CONSTRAINT fk_obra_libro    FOREIGN KEY (isbn)
        REFERENCES AJJC_LIBRO(isbn)
    -- TRIGGER: valida que el ISBN haya sido analizado por id_club
);
 
 
-- ----------------------------------------------------------------
-- 23. AJJC_PRESENTACION
-- Cada puesta en escena de una obra. Una obra puede presentarse
--   varias veces en fechas distintas.
-- PK compuesta (id_obra, fecha).
-- cant_entradas_vendidas: NULL hasta que se cierra la presentacion.
-- estrellas_obtenidas: NULL hasta que el publico vota.
-- La recaudacion total se calcula: cant_entradas * costo_entrada
--   (costo_entrada vive en OBRA_TEATRAL).
-- ----------------------------------------------------------------
CREATE TABLE AJJC_PRESENTACION (
    id_obra                     NUMBER      NOT NULL,
    fecha                       DATE        NOT NULL,
    cant_entradas_vendidas      NUMBER      NULL,
    estrellas_obtenidas         NUMBER(1)   NULL,
    CONSTRAINT pk_presentacion PRIMARY KEY (id_obra, fecha),
    CONSTRAINT chk_pres_estrellas   CHECK (estrellas_obtenidas BETWEEN 0 AND 5),
    CONSTRAINT chk_pres_entradas    CHECK (cant_entradas_vendidas >= 0),
    CONSTRAINT fk_pres_obra FOREIGN KEY (id_obra)
        REFERENCES AJJC_OBRA_TEATRAL(id_obra)
);
 
 
-- ----------------------------------------------------------------
-- 24. AJJC_ELENCO
-- Actores de una obra. Pueden ser del club organizador
--   o de clubes asociados.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_ELENCO (
    id_obra     NUMBER  NOT NULL,
    id_miembro  NUMBER  NOT NULL,
    CONSTRAINT pk_elenco PRIMARY KEY (id_obra, id_miembro),
    CONSTRAINT fk_el_obra       FOREIGN KEY (id_obra)
        REFERENCES AJJC_OBRA_TEATRAL(id_obra),
    CONSTRAINT fk_el_miembro    FOREIGN KEY (id_miembro)
        REFERENCES AJJC_MIEMBRO(id_miembro)
);
 
 
-- ----------------------------------------------------------------
-- 25. AJJC_MEJOR_ACTOR
-- Resultado de la votacion del publico por presentacion.
-- Permite empates: multiples filas por presentacion.
-- FK1 compuesta (id_obra, fecha) -> PRESENTACION.
-- FK2 compuesta (id_obra, id_miembro) -> ELENCO
--   para garantizar que el mejor actor haya actuado en esa obra.
-- ----------------------------------------------------------------
CREATE TABLE AJJC_MEJOR_ACTOR (
    id_obra     NUMBER  NOT NULL,
    fecha       DATE    NOT NULL,
    id_miembro  NUMBER  NOT NULL,
    CONSTRAINT pk_mejor_actor PRIMARY KEY (id_obra, fecha, id_miembro),
    CONSTRAINT fk_ma_presentacion FOREIGN KEY (id_obra, fecha)
        REFERENCES AJJC_PRESENTACION(id_obra, fecha),
    CONSTRAINT fk_ma_elenco FOREIGN KEY (id_obra, id_miembro)
        REFERENCES AJJC_ELENCO(id_obra, id_miembro)
);
 
 
-- ================================================================
-- FIN DEL SCRIPT
-- Triggers pendientes (implementar por separado):
--   - AJJC_AUTOR: al menos un campo de nombre NOT NULL
--   - AJJC_TELEFONO: arco exclusivo miembro/representante
--   - AJJC_MIEMBRO_IDIOMA: arco exclusivo miembro/club
--   - AJJC_MIEMBRO: menores de 18 requieren representante
--   - AJJC_CLUB_ASOCIADO: id_club_1 != id_club_2
--   - AJJC_GRUPO_DE_LECTURA: hora entre 17:00 y 19:00
--   - AJJC_GRUPO_DE_LECTURA: split automatico por tamanio
--   - AJJC_MEMBRESIA: un miembro no activo en mas de un club
--   - AJJC_MEMBRESIA: renovacion automatica anual
--   - AJJC_LIBRO: evitar ciclos en cadena sig/prev
--   - AJJC_CALENDARIO_MES: fecha debe ser dia_reunion del grupo
--   - AJJC_INASISTENCIA: expulsion automatica si >30% bimestral
--   - AJJC_OBRA_TEATRAL: ISBN debe haber sido analizado por el club
--   - AJJC_LIBRO_PREFERIDO: exactamente 3 por miembro, orden unico
-- ================================================================