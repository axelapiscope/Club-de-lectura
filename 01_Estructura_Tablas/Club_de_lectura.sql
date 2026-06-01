-- =========================================================
-- BLOQUE DE ENTIDADES: CIUDAD, LIBRO, CALENDARIO, INASISTENCIA, PAGO Y PRESENTACIÓN
-- =========================================================

-- 1. CIUDAD (Requiere que ya exista la tabla PAIS)
CREATE TABLE CIUDAD (
    id_ciudad        NUMBER,
    nombre_ciudad    VARCHAR2(100) NOT NULL,
    id_pais          NUMBER NOT NULL,
    CONSTRAINT pk_ciudad PRIMARY KEY (id_ciudad),
    CONSTRAINT fk_ciudad_pais FOREIGN KEY (id_pais) REFERENCES PAIS(id_pais)
);

-- 2. LIBRO (Independiente)
CREATE TABLE LIBRO (
    isbn                            VARCHAR2(20), 
    titulo_original                 VARCHAR2(250) NOT NULL,
    ano_publicacion_primera_edicion NUMBER(4) NOT NULL,
    cantidad_paginas                NUMBER NOT NULL,
    sinopsis                        CLOB NOT NULL, 
    tipo_narrativa                  VARCHAR2(100) NOT NULL,
    temas_resumen                   VARCHAR2(500), 
    CONSTRAINT pk_libro PRIMARY KEY (isbn)
);

-- 3. CALENDARIO_MES (Independiente)
CREATE TABLE CALENDARIO_MES (
    fecha_reunion    DATE,
    CONSTRAINT pk_calendario_mes PRIMARY KEY (fecha_reunion)
);

-- 4. INASISTENCIA (Requiere que ya exista la tabla LECTOR)
CREATE TABLE INASISTENCIA (
    id_miembro       NUMBER NOT NULL,
    fecha_reunion    DATE NOT NULL,
    CONSTRAINT pk_inasistencia PRIMARY KEY (id_miembro, fecha_reunion),
    CONSTRAINT fk_inasistencia_lector FOREIGN KEY (id_miembro) REFERENCES LECTOR(id_miembro),
    CONSTRAINT fk_inasistencia_calen FOREIGN KEY (fecha_reunion) REFERENCES CALENDARIO_MES(fecha_reunion)
);

-- 5. PAGO (Requiere que ya exista HISTORIAL_MEMBRESIA y PAIS)
CREATE TABLE PAGO (
    id_pago          NUMBER,
    id_membresia     NUMBER NOT NULL,
    fecha_pago       DATE NOT NULL,
    monto_pago       NUMBER(10,2) NOT NULL,
    id_pais          NUMBER NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY (id_pago),
    CONSTRAINT fk_pago_membresia FOREIGN KEY (id_membresia) REFERENCES HISTORIAL_MEMBRESIA(id_membresia),
    CONSTRAINT fk_pago_pais FOREIGN KEY (id_pais) REFERENCES PAIS(id_pais)
);

-- 6. PRESENTACION (Requiere que ya exista OBRA_TEATRAL y CLUB_DE_LECTURA)
CREATE TABLE PRESENTACION (
    id_presentacion  NUMBER,
    id_obra          NUMBER NOT NULL,
    id_club          NUMBER NOT NULL,
    fecha_pres       DATE NOT NULL,
    hora_inicio      VARCHAR2(10) NOT NULL,
    duracion_total   NUMBER NOT NULL, -- Minutos
    costo_entrada    NUMBER(10,2) NOT NULL,
    valoracion_stars NUMBER(1), -- 1 a 5 estrellas
    CONSTRAINT pk_presentacion PRIMARY KEY (id_presentacion),
    CONSTRAINT fk_pres_obra FOREIGN KEY (id_obra) REFERENCES OBRA_TEATRAL(id_obra),
    CONSTRAINT fk_pres_club FOREIGN KEY (id_club) REFERENCES CLUB_DE_LECTURA(id_club),
    CONSTRAINT chk_valoracion CHECK (valoracion_stars BETWEEN 1 AND 5)
);