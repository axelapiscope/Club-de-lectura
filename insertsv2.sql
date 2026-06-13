-- ============================================================
-- 01_INSERTS_V4B_GRUPO7.SQL  — Secciones corregidas
-- Columnas reales de la BD (deducidas de inserts exitosos previos)
-- Correr DESPUÉS de 00_limpieza_v2.sql
-- ============================================================
SET DEFINE OFF;

-- ============================================================
-- BLOQUE 1 — Catálogos (sin cambios, se re-insertan tras limpieza)
-- ============================================================
-- 1. PAISES
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('1','Venezuela','VES','venezolano');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('2','Mexico','MXN','mexicano');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('3','Estados Unidos','USD','estadounidense');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('4','Reino Unido','GBP','britanico');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('5','Alemania','EUR','aleman');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('6','Portugal','EUR','portugues');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('7','Colombia','COP','colombiano');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('8','Japon','JPY','japones');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('9','Chile','CLP','chileno');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('10','Argentina','ARS','argentino');
Insert into ACJJ_PAISES (ID_PAIS,NOMBRE_PAIS,MONEDA_LOCAL,NACIONALIDAD) values ('11','Italia','EUR','italiano');

-- 2. IDIOMAS
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('1','Espanol');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('2','Ingles');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('3','Italiano');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('4','Frances');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('5','Aleman');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('6','Portugues');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('7','Japones');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('8','Ruso');
Insert into ACJJ_IDIOMAS (ID_IDIOMA,NOMBRE) values ('9','Portugues BR');

-- 3. INSTITUCIONES
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('1','Biblioteca Nacional','BIBLIOTECA');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('2','Universidad Central','UNIVERSIDAD');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('3','Colegio San Ignacio','COLEGIO');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('4','Biblioteca Municipal','BIBLIOTECA');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('5','Universidad Catolica','UNIVERSIDAD');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('6','Casa de la Cultura','OTRO');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('7','Colegio Italiano','COLEGIO');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('8','Biblioteca Pubblica Roma','BIBLIOTECA');
Insert into ACJJ_INSTITUCIONES (ID_INSTITUCION,NOMBRE,TIPO) values ('9','Centro Cultural BA','OTRO');

-- 4. AUTORES
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('1','Teresa','de la Parra',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('2','Carlos','Fuentes',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('3','Harper','Lee',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('4','Stephen','King',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('5','C.S.','Lewis',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('6','Mario','Puzo',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('7','Rick','Riordan',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('8','Patrick','Suskind',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('9','Jose','Saramago',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('10','Laura','Esquivel',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('11','Gabriel','Garcia Marquez',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('12','Emily','Bronte',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('13','Haruki','Murakami',null);
Insert into ACJJ_AUTORES (ID_AUTOR,NOMBRE,APELLIDO,PSEUDONIMO) values ('14','Isabel','Allende',null);

-- 5. CIUDADES
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('1','1','Caracas');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('1','2','Maracaibo');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('2','1','Ciudad de Mexico');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('3','1','Nueva York');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('4','1','Londres');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('5','1','Colonia');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('6','1','Lisboa');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('7','1','Bogota');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('8','1','Tokio');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('9','1','Santiago');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('10','1','Buenos Aires');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('11','1','Roma');
Insert into ACJJ_CIUDADES (ID_PAIS,ID_CIUDAD,NOMBRE_CIUDAD) values ('11','2','Milan');

-- ============================================================
-- FIX 1: LIBROS — columna ISBN_LIB_SIG no existe en la BD
--         Se omite; se usa solo ISBN_LIB_ANTERIOR para la trilogía
-- ============================================================
-- 6. LIBROS (16 libros)
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9788490638743','Ifigenia',to_date('01/01/1924','DD/MM/YYYY'),'544','Maria Eugenia Alonso regresa a Caracas tras anos en Paris y choca con la rigida sociedad venezolana que no le permite elegir su destino.','Drama','Feminismo, sociedad','1',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9786071600004','Aura',to_date('01/01/1962','DD/MM/YYYY'),'96','Un joven historiador acepta un trabajo en una mansion oscura donde convive con una anciana y su sobrina Aura envueltos en atmosfera fantastica.','Novela corta','Fantastico, misterio','2',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9780061743528','Matar a un ruisenor',to_date('01/01/1960','DD/MM/YYYY'),'336','Scout Finch narra como su padre Atticus defiende a un hombre negro injustamente acusado en el sur de EEUU.','Ficcion Hist','Justicia social','3',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9788490328729','El resplandor',to_date('01/01/1977','DD/MM/YYYY'),'672','Jack Torrance lleva a su familia a cuidar un hotel aislado. La historia del lugar despierta fuerzas sobrenaturales.','Terror','Terror, sobrenatural','3',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9781400334599','El leon la bruja y el ropero',to_date('01/01/1950','DD/MM/YYYY'),'208','Cuatro hermanos descubren un ropero que conduce al magico mundo de Narnia.','Fantasia','Fantasia, aventura','4',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9780451205766','El padrino',to_date('01/01/1969','DD/MM/YYYY'),'448','La saga de la familia Corleone y la lucha por el poder entre familias mafiosas.','Novela criminal','Crimen, poder','3',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9788432217890','El perfume',to_date('01/01/1985','DD/MM/YYYY'),'304','Grenouille tiene un extraordinario olfato y obsesion por crear el perfume perfecto.','Suspenso','Terror, historico','5',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9786071100238','Como agua para chocolate',to_date('01/01/1989','DD/MM/YYYY'),'256','Tita no puede casarse; sus emociones se transfieren a la comida que prepara.','Realismo magico','Amor, tradicion','2',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9780307389732','El amor en los tiempos del colera',to_date('01/01/1985','DD/MM/YYYY'),'422','Florentino Ariza espera mas de cincuenta anos para reunirse con Fermina Daza.','Romance','Amor, tiempo','7',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9780141439556','Cumbres borrascosas',to_date('01/01/1847','DD/MM/YYYY'),'352','La historia de Heathcliff y su amor destructivo por Catherine.','Novela gotica','Amor, venganza','4',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9788483835043','Kafka en la orilla',to_date('01/01/2002','DD/MM/YYYY'),'640','Dos historias se entrelazan en un universo de realismo magico y simbolismo.','Surrealismo','Identidad, misterio','8',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9780060535162','La ciudad de las bestias',to_date('01/01/2002','DD/MM/YYYY'),'416','Alexander Cold viaja al Amazonas con su abuela y se adentra en la selva.','Aventura','Aventura, naturaleza','9',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9781423160915','La espada del tiempo',to_date('01/01/2015','DD/MM/YYYY'),'544','Magnus Chase muere en Boston y despierta en el Valhalla como hijo de un dios nordico.','Mitologia','Mitologia nordica','3',null);
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9781423160922','El martillo de Thor',to_date('01/01/2016','DD/MM/YYYY'),'512','Magnus Chase debe recuperar el martillo de Thor.','Epica','Mitologia nordica','3','9781423160915');
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9781484788394','El barco de los muertos',to_date('01/01/2017','DD/MM/YYYY'),'528','Magnus Chase debe llegar al barco Naglfar antes del Ragnarok.','Juv Ficcion','Mitologia nordica','3','9781423160922');
Insert into ACJJ_LIBROS (ISBN,TITULO,ANO_PUBLICACION,CAN_PAGINAS,SINOPSIS,TIPO_NARRATIVA,TEMAS,ID_PAIS,ISBN_LIB_ANTERIOR) values ('9788420471839','Ensayo sobre la ceguera',to_date('01/01/1995','DD/MM/YYYY'),'368','Una ceguera blanca se propaga epidemicamente.','Distopia','Sociedad, humanidad','6',null);
-- Nota: ISBN_LIB_SIG no existe en la BD actual; el encadenamiento hacia
-- adelante (sig) no se puede registrar. Solo 'anterior' queda disponible.

-- 7. LIBROS_AUTORES
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9788490638743','1');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9786071600004','2');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9780061743528','3');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9788490328729','4');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9781400334599','5');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9780451205766','6');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9788432217890','8');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9786071100238','10');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9780307389732','11');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9780141439556','12');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9788483835043','13');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9780060535162','14');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9781423160915','7');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9781423160922','7');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9781484788394','7');
Insert into ACJJ_LIBROS_AUTORES (ISBN,ID_AUTOR) values ('9788420471839','9');

-- 8. REPRESENTANTES
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('1','V-10234567','Carlos','Rodriguez','Perez','carlos.rodriguez@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('2','V-11345678','Maria','Gonzalez','Lopez','maria.gonzalez@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('3','V-12456789','Jose','Martinez','Suarez','jose.martinez@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('4','V-13567890','Ana','Hernandez','Torres','ana.hernandez@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('5','V-14567891','Luis','Gomez','Mendez','luis.gomez@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('6','V-15678902','Elena','Ruiz','Paz','elena.ruiz@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('7','V-16789013','Miguel','Castro','Rios','miguel.castro@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('8','V-17890124','Sara','Ortiz','Luna','sara.ortiz@email.com');
Insert into ACJJ_REPRESENTANTES (ID_REP,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL) values ('9','V-18901235','Pedro','Nunez','Soto','pedro.nunez@email.com');

-- 9. CLUBES_DE_LECTURA
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('1','Club Catatumbo','catatumbo@clubes.com','Av. Libertador, Caracas','1050','1','1','S',null);
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('2','Club Sant''Alessio','santalessio@clubes.it','Via Sant''Alessio 12, Roma','00153','1','11','S',null);
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('4','Sociedad Literaria Secreta','soclit.secreta@clubes.ar','Calle Florida 567, Buenos Aires','C1005','1','10','S',null);
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('5','Club de Lectura Gladiadores','gladiadores@clubes.it','Via Appia 45, Roma','00178','1','11','S',null);
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('6','Circulo Literario de Roma','circuloroma@clubes.it','Piazza Navona 8, Roma','00186','1','11','S',null);
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('7','El Club de la Colmena','lacolmena@clubes.com','Av. Principal de las Mercedes, Caracas','1060','1','1','S',null);
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('8','Letras de Caracas','letrascaracas@clubes.com','Calle El Bosque, Chacao, Caracas','1060','1','1','S',null);
Insert into ACJJ_CLUBES_DE_LECTURA (ID_CLUB,NOMBRE_CLUB,EMAIL,DIRECCION,COD_POSTAL,ID_CIUDAD,ID_PAIS,TIENE_MEMBRESIA,ID_INSTITUCION) values ('9','Club Lectura Buenos Aires','bsaslectura@clubes.ar','Av. Corrientes 1234, Buenos Aires','C1043','1','10','S',null);

-- 10. CLUBES_ASOCIADOS
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('2','5');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('2','6');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('5','6');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('1','7');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('1','8');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('7','8');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('4','9');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('1','4');
Insert into ACJJ_CLUBES_ASOCIADOS (ID_CLUB1,ID_CLUB2) values ('2','9');

-- 11-14. LECTORES, TELEFONOS, IDIOM_CLUB_LEC, LIBROS_PREFERIDOS
-- (se re-insertan tras 00_limpieza_v2)

-- 11. LECTORES (96)
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('1','V-30111001','Sofia','Rodriguez','Garcia','sofia.rodriguez@email.com',to_date('12/03/2015','DD/MM/YYYY'),'1','1');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('2','V-30222002','Andres','Gonzalez','Ramos','andres.gonzalez@email.com',to_date('25/07/2015','DD/MM/YYYY'),'1','2');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('3','V-30333003','Isabella','Martinez','Vargas','isabella.martinez@email.com',to_date('08/01/2016','DD/MM/YYYY'),'1','3');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('4','V-30444004','Diego','Hernandez','Molina','diego.hernandez@email.com',to_date('30/11/2015','DD/MM/YYYY'),'1','4');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('5','V-20111005','Valentina','Perez','Castro','valentina.perez@email.com',to_date('14/05/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('6','V-20222006','Gabriel','Lopez','Sanchez','gabriel.lopez@email.com',to_date('20/09/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('7','V-20333007','Camila','Torres','Reyes','camila.torres@email.com',to_date('18/02/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('8','V-20444008','Sebastian','Ramirez','Flores','sebastian.ramirez@email.com',to_date('03/12/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('9','V-10111009','Laura','Diaz','Mendez','laura.diaz@email.com',to_date('22/06/1990','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('10','V-10222010','Miguel','Morales','Gutierrez','miguel.morales@email.com',to_date('15/11/1985','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('11','V-10333011','Patricia','Jimenez','Herrera','patricia.jimenez@email.com',to_date('08/03/1992','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('12','V-10444012','Ricardo','Vargas','Medina','ricardo.vargas@email.com',to_date('27/08/1988','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('13','IT-AA111013','Marco','Rossi','Ferrari','marco.rossi@email.it',to_date('10/04/1988','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('14','IT-AA222014','Giulia','Bianchi','Romano','giulia.bianchi@email.it',to_date('23/08/1992','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('15','IT-AA333015','Luca','Conti','Esposito','luca.conti@email.it',to_date('05/12/1985','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('16','IT-AA444016','Sofia','Ricci','Marino','sofia.ricci@email.it',to_date('17/03/1995','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('17','AR-CC111021','Florencia','Lopez','Torres','florencia.lopez@email.ar',to_date('17/01/1989','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('18','AR-CC222022','Matias','Gonzalez','Ruiz','matias.gonzalez@email.ar',to_date('30/06/1984','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('19','AR-CC333023','Agustina','Perez','Diaz','agustina.perez@email.ar',to_date('12/09/1996','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('20','AR-CC444024','Nicolas','Ramirez','Alvarez','nicolas.ramirez@email.ar',to_date('05/04/1991','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('21','IT-DD111025','Antonio','Colombo','Bruno','antonio.colombo@email.it',to_date('22/11/1986','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('22','IT-DD222026','Elena','De Luca','Gallo','elena.deluca@email.it',to_date('14/03/1993','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('23','IT-DD333027','Roberto','Mancini','Costa','roberto.mancini@email.it',to_date('08/07/1988','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('24','IT-DD444028','Chiara','Fontana','Leone','chiara.fontana@email.it',to_date('25/01/1997','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('25','IT-EE111029','Francesco','Barbieri','Serra','francesco.barbieri@email.it',to_date('16/09/1982','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('26','IT-EE222030','Valentina','Martini','Vitale','valentina.martini@email.it',to_date('03/12/1994','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('27','IT-EE333031','Andrea','Gentile','Marini','andrea.gentile@email.it',to_date('27/05/1990','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('28','IT-EE444032','Alessia','Caruso','Pellegrini','alessia.caruso@email.it',to_date('19/08/1987','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('29','V-15111033','Daniela','Castillo','Rojas','daniela.castillo@email.com',to_date('14/02/1991','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('30','V-15222034','Eduardo','Mendoza','Salazar','eduardo.mendoza@email.com',to_date('09/07/1986','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('31','V-15333035','Paola','Acosta','Fuentes','paola.acosta@email.com',to_date('28/11/1994','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('32','V-15444036','Alejandro','Silva','Campos','alejandro.silva@email.com',to_date('15/04/1989','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('33','V-16111037','Carmen','Blanco','Delgado','carmen.blanco@email.com',to_date('11/06/1983','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('34','V-16222038','Fernando','Cruz','Parra','fernando.cruz@email.com',to_date('24/10/1990','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('35','V-16333039','Monica','Vega','Ibarra','monica.vega@email.com',to_date('07/03/1987','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('36','V-16444040','Roberto','Mora','Escobar','roberto.mora@email.com',to_date('19/01/1992','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('37','AR-BB111017','Martina','Garcia','Lopez','martina.garcia@email.ar',to_date('14/07/1990','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('38','AR-BB222018','Julian','Martinez','Perez','julian.martinez@email.ar',to_date('28/02/1987','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('39','AR-BB333019','Luciana','Rodriguez','Sanchez','luciana.rodriguez@email.ar',to_date('09/10/1993','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('40','AR-BB444020','Tomas','Fernandez','Gomez','tomas.fernandez@email.ar',to_date('21/05/1991','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('41','IT-2001','Matteo','Ricci','Bianco','matteo.ricci@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','5');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('42','IT-2002','Giulia','Romano','Costa','giulia.romano@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','6');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('43','IT-2003','Lorenzo','Gallo','Conti','lorenzo.gallo@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','7');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('44','IT-2004','Martina','Colombo','Rossi','martina.colombo@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','8');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('45','IT-2005','Leonardo','Ferrari','Esposito','leonardo.ferrari@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('46','IT-2006','Aurora','Bruno','Russo','aurora.bruno@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('47','IT-2007','Alessandro','Greco','Marino','alessandro.greco@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('48','IT-2008','Ginevra','Giordano','Rizzo','ginevra.giordano@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('49','AR-4001','Thiago','Lopez','Suarez','thiago.lopez@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','9');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('50','AR-4002','Valentina','Gomez','Paz','valentina.gomez@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','1');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('51','AR-4003','Santino','Perez','Luna','santino.perez@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','2');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('52','AR-4004','Camila','Diaz','Soto','camila.diaz@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','3');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('53','AR-4005','Mateo','Martinez','Ruiz','mateo.martinez@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('54','AR-4006','Sofia','Romero','Alvarez','sofia.romero@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('55','AR-4007','Bautista','Suarez','Castro','bautista.suarez@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('56','AR-4008','Emma','Alvarez','Rios','emma.alvarez@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('57','IT-5001','Francesco','Moretti','Lombardi','francesco.moretti@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','4');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('58','IT-5002','Alice','Barbieri','Fontana','alice.barbieri@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','5');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('59','IT-5003','Gabriele','Caruso','Leone','gabriele.caruso@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','6');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('60','IT-5004','Greta','Santoro','Domenico','greta.santoro@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','7');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('61','IT-5005','Edoardo','Russo','Martini','edoardo.russo@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('62','IT-5006','Giorgia','Galli','Pellegrini','giorgia.galli@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('63','IT-5007','Tommaso','Palumbo','Vitale','tommaso.palumbo@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('64','IT-5008','Beatrice','Longo','Serra','beatrice.longo@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('65','IT-6001','Riccardo','Marino','Sanna','riccardo.marino@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','8');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('66','IT-6002','Chiara','Gentile','Coppola','chiara.gentile@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','9');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('67','IT-6003','Mattia','De Luca','Ferri','mattia.deluca@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','1');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('68','IT-6004','Anna','Costa','Parisi','anna.costa@email.it',to_date('10/05/2015','DD/MM/YYYY'),'11','2');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('69','IT-6005','Emanuele','Bianchi','De Rosa','emanuele.bianchi@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('70','IT-6006','Vittoria','Mancini','Gatti','vittoria.mancini@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('71','IT-6007','Federico','Rizzo','Conte','federico.rizzo@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('72','IT-6008','Ludovica','Romano','Amato','ludovica.romano@email.it',to_date('20/08/2010','DD/MM/YYYY'),'11',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('73','V-7001','Sebastian','Mendoza','Rojas','sebastian.mendoza@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','3');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('74','V-7002','Valeria','Castillo','Salazar','valeria.castillo@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','4');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('75','V-7003','Diego','Acosta','Fuentes','diego.acosta@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','5');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('76','V-7004','Victoria','Silva','Campos','victoria.silva@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','6');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('77','V-7005','Alejandro','Blanco','Delgado','alejandro.blanco@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('78','V-7006','Mariana','Cruz','Parra','mariana.cruz@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('79','V-7007','Samuel','Vega','Ibarra','samuel.vega@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('80','V-7008','Isabella','Mora','Escobar','isabella.mora@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('81','V-8001','Gabriel','Machado','Rios','gabriel.machado@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','7');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('82','V-8002','Daniela','Ochoa','Rivas','daniela.ochoa@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','8');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('83','V-8003','Andres','Navarro','Pina','andres.navarro@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','9');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('84','V-8004','Andrea','Paredes','Rojas','andrea.paredes@email.com',to_date('10/05/2015','DD/MM/YYYY'),'1','1');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('85','V-8005','Santiago','Quintero','Sosa','santiago.quintero@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('86','V-8006','Gabriela','Soto','Guerra','gabriela.soto@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('87','V-8007','Matias','Villalobos','Mendez','matias.villalobos@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('88','V-8008','Paola','Bracho','Marquez','paola.bracho@email.com',to_date('20/08/2010','DD/MM/YYYY'),'1',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('89','AR-9001','Joaquin','Fernandez','Gimenez','joaquin.fernandez@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','2');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('90','AR-9002','Martina','Rodriguez','Herrera','martina.rodriguez@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','3');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('91','AR-9003','Agustin','Garcia','Benitez','agustin.garcia@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','4');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('92','AR-9004','Catalina','Martinez','Cabrera','catalina.martinez@email.ar',to_date('10/05/2015','DD/MM/YYYY'),'10','5');
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('93','AR-9005','Nicolas','Gomez','Medina','nicolas.gomez@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('94','AR-9006','Luciana','Lopez','Paz','luciana.lopez@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('95','AR-9007','Tomas','Perez','Castillo','tomas.perez@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);
Insert into ACJJ_LECTORES (ID_LECTOR,DOC_IDENTIDAD,P_NOMBRE,P_APELLIDO,S_APELLIDO,EMAIL,FECHA_NAC,ID_PAIS,ID_REP) values ('96','AR-9008','Delfina','Diaz','Navarro','delfina.diaz@email.ar',to_date('20/08/2010','DD/MM/YYYY'),'10',null);

-- 12. TELEFONOS
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('1','58','212','5551001','9',null);
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('2','58','212','5551002','10',null);
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('3','39','06','5551003','13',null);
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('4','58','414','5552001','11',null);
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('5','39','06','5552002','14',null);
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('6','54','11','5552003','37',null);
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('7','58','414','5553001',null,'1');
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('8','58','414','5553002',null,'2');
Insert into ACJJ_TELEFONOS (ID_TEL,CODIGO_PAIS,CODIGO_AREA,NUMERO,ID_LECTOR,ID_REP) values ('9','58','414','5553003',null,'3');

-- 13. IDIOM_CLUB_LEC
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('1','1',null,'1');
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('2','3',null,'2');
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('3','3',null,'5');
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('4','3',null,'6');
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('5','1',null,'7');
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('6','1','9',null);
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('7','2','9',null);
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('8','3','13',null);
Insert into ACJJ_IDIOM_CLUB_LEC (ID,ID_IDIOMA,ID_LECTOR,ID_CLUB) values ('9','1','37',null);

-- 14. LIBROS_PREFERIDOS
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('9','1','9788490638743');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('9','2','9780307389732');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('9','3','9786071100238');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('10','1','9780451205766');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('10','2','9788432217890');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('10','3','9788490328729');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('13','1','9786071600004');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('13','2','9788483835043');
Insert into ACJJ_LIBROS_PREFERIDOS (ID_LECTOR,ORDEN_PREF,ISBN) values ('13','3','9780141439556');

-- 15. GRUPOS_DE_LECTURA
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('1','1','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('1','2','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('03/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('1','3','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('04/06/2026','DD/MM/YYYY'),to_date('01/01/2026 18:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('2','1','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('03/06/2026','DD/MM/YYYY'),to_date('01/01/2026 18:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('2','2','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('2','3','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('4','1','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('05/06/2026','DD/MM/YYYY'),to_date('01/01/2026 18:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('4','2','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('4','3','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('5','1','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:30:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('5','2','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('5','3','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('6','1','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 18:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('6','2','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('6','3','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('7','1','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('04/06/2026','DD/MM/YYYY'),to_date('01/01/2026 18:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('7','2','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('7','3','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('8','1','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('05/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('8','2','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('8','3','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('9','1','A',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 18:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('9','2','I',to_date('10/01/2026','DD/MM/YYYY'),to_date('01/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));
Insert into ACJJ_GRUPOS_DE_LECTURA (ID_CLUB,ID_GRUPO,TIPO,FECHA_CREACION,DIA_REUNION,HORA_INI_REU) values ('9','3','J',to_date('10/01/2026','DD/MM/YYYY'),to_date('02/06/2026','DD/MM/YYYY'),to_date('01/01/2026 17:00:00','DD/MM/YYYY HH24:MI:SS'));

-- 16. MEMBRESIAS (96)
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('1','1','1',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('2','1','2',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('3','1','3',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('4','1','4',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('5','1','5',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('6','1','6',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('7','1','7',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('8','1','8',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('9','1','9',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('10','1','10',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('11','1','11',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('12','1','12',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('13','2','13',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('14','2','14',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('15','2','15',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('16','2','16',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('17','4','17',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('18','4','18',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('19','4','19',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('20','4','20',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('21','5','21',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('22','5','22',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('23','5','23',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('24','5','24',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('25','6','25',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('26','6','26',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('27','6','27',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('28','6','28',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('29','7','29',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('30','7','30',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('31','7','31',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('32','7','32',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('33','8','33',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('34','8','34',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('35','8','35',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('36','8','36',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('37','9','37',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('38','9','38',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('39','9','39',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('40','9','40',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('41','2','41',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('42','2','42',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('43','2','43',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('44','2','44',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('45','2','45',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('46','2','46',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('47','2','47',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('48','2','48',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('49','4','49',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('50','4','50',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('51','4','51',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('52','4','52',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('53','4','53',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('54','4','54',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('55','4','55',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('56','4','56',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('57','5','57',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('58','5','58',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('59','5','59',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('60','5','60',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('61','5','61',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('62','5','62',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('63','5','63',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('64','5','64',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('65','6','65',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('66','6','66',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('67','6','67',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('68','6','68',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('69','6','69',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('70','6','70',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('71','6','71',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('72','6','72',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('73','7','73',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('74','7','74',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('75','7','75',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('76','7','76',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('77','7','77',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('78','7','78',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('79','7','79',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('80','7','80',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('81','8','81',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('82','8','82',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('83','8','83',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('84','8','84',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('85','8','85',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('86','8','86',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('87','8','87',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('88','8','88',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('89','9','89',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('90','9','90',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('91','9','91',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('92','9','92',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('93','9','93',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('94','9','94',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('95','9','95',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);
Insert into ACJJ_MEMBRESIAS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,FECHA_INGRESO,ESTATUS,FECHA_RETIRO,MOTIVO_RETIRO) values ('96','9','96',to_date('15/01/2026','DD/MM/YYYY'),'A',null,null);

-- 17. PAGOS (96)
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('1','1','1','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('2','1','2','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('3','1','3','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('4','1','4','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('5','1','5','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('6','1','6','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('7','1','7','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('8','1','8','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('9','1','9','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('10','1','10','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('11','1','11','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('12','1','12','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('13','2','13','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('14','2','14','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('15','2','15','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('16','2','16','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('17','4','17','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('18','4','18','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('19','4','19','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('20','4','20','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('21','5','21','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('22','5','22','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('23','5','23','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('24','5','24','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('25','6','25','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('26','6','26','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('27','6','27','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('28','6','28','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('29','7','29','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('30','7','30','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('31','7','31','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('32','7','32','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('33','8','33','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('34','8','34','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('35','8','35','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('36','8','36','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('37','9','37','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('38','9','38','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('39','9','39','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('40','9','40','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('41','2','41','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('42','2','42','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('43','2','43','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('44','2','44','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('45','2','45','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('46','2','46','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('47','2','47','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('48','2','48','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('49','4','49','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('50','4','50','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('51','4','51','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('52','4','52','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('53','4','53','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('54','4','54','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('55','4','55','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('56','4','56','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('57','5','57','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('58','5','58','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('59','5','59','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('60','5','60','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('61','5','61','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('62','5','62','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('63','5','63','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('64','5','64','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('65','6','65','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('66','6','66','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('67','6','67','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('68','6','68','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('69','6','69','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('70','6','70','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('71','6','71','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('72','6','72','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('73','7','73','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('74','7','74','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('75','7','75','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('76','7','76','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('77','7','77','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('78','7','78','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('79','7','79','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('80','7','80','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('81','8','81','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('82','8','82','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('83','8','83','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('84','8','84','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('85','8','85','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('86','8','86','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('87','8','87','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('88','8','88','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('89','9','89','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('90','9','90','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('91','9','91','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('92','9','92','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('93','9','93','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('94','9','94','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('95','9','95','1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_PAGOS (ID_LECTOR,ID_CLUB,ID_MEMBRESIA,ID_PAGO,FECHA_PAGO) values ('96','9','96','1',to_date('15/01/2026','DD/MM/YYYY'));

-- ============================================================
-- FIX 2: GRUPOS_LECTORES — ID_CLUB_M no existe; se usa ID_CLUB
--   Estructura real: (ID_LECTOR, FECHA_INICIO, ID_GRUPO, ID_CLUB_G,
--                     ID_MEMBRESIA, ID_CLUB, FECHA_FIN)
-- ============================================================
-- 18. GRUPOS_LECTORES (96) — corregido: sin ID_CLUB_G
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('1',to_date('15/01/2026','DD/MM/YYYY'),'1','1','1',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('2',to_date('15/01/2026','DD/MM/YYYY'),'1','1','2',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('3',to_date('15/01/2026','DD/MM/YYYY'),'1','1','3',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('4',to_date('15/01/2026','DD/MM/YYYY'),'1','1','4',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('5',to_date('15/01/2026','DD/MM/YYYY'),'2','1','5',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('6',to_date('15/01/2026','DD/MM/YYYY'),'2','1','6',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('7',to_date('15/01/2026','DD/MM/YYYY'),'2','1','7',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('8',to_date('15/01/2026','DD/MM/YYYY'),'2','1','8',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('10',to_date('15/01/2026','DD/MM/YYYY'),'3','1','10',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('11',to_date('15/01/2026','DD/MM/YYYY'),'3','1','11',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('12',to_date('15/01/2026','DD/MM/YYYY'),'3','1','12',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('13',to_date('15/01/2026','DD/MM/YYYY'),'1','2','13',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('14',to_date('15/01/2026','DD/MM/YYYY'),'1','2','14',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('15',to_date('15/01/2026','DD/MM/YYYY'),'1','2','15',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('16',to_date('15/01/2026','DD/MM/YYYY'),'1','2','16',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('17',to_date('15/01/2026','DD/MM/YYYY'),'1','4','17',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('18',to_date('15/01/2026','DD/MM/YYYY'),'1','4','18',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('19',to_date('15/01/2026','DD/MM/YYYY'),'1','4','19',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('20',to_date('15/01/2026','DD/MM/YYYY'),'1','4','20',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('21',to_date('15/01/2026','DD/MM/YYYY'),'1','5','21',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('22',to_date('15/01/2026','DD/MM/YYYY'),'1','5','22',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('23',to_date('15/01/2026','DD/MM/YYYY'),'1','5','23',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('24',to_date('15/01/2026','DD/MM/YYYY'),'1','5','24',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('25',to_date('15/01/2026','DD/MM/YYYY'),'1','6','25',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('26',to_date('15/01/2026','DD/MM/YYYY'),'1','6','26',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('27',to_date('15/01/2026','DD/MM/YYYY'),'1','6','27',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('28',to_date('15/01/2026','DD/MM/YYYY'),'1','6','28',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('29',to_date('15/01/2026','DD/MM/YYYY'),'1','7','29',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('30',to_date('15/01/2026','DD/MM/YYYY'),'1','7','30',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('31',to_date('15/01/2026','DD/MM/YYYY'),'1','7','31',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('32',to_date('15/01/2026','DD/MM/YYYY'),'1','7','32',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('33',to_date('15/01/2026','DD/MM/YYYY'),'1','8','33',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('34',to_date('15/01/2026','DD/MM/YYYY'),'1','8','34',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('35',to_date('15/01/2026','DD/MM/YYYY'),'1','8','35',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('36',to_date('15/01/2026','DD/MM/YYYY'),'1','8','36',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('37',to_date('15/01/2026','DD/MM/YYYY'),'1','9','37',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('38',to_date('15/01/2026','DD/MM/YYYY'),'1','9','38',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('39',to_date('15/01/2026','DD/MM/YYYY'),'1','9','39',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('40',to_date('15/01/2026','DD/MM/YYYY'),'1','9','40',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('41',to_date('15/01/2026','DD/MM/YYYY'),'2','2','41',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('42',to_date('15/01/2026','DD/MM/YYYY'),'2','2','42',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('43',to_date('15/01/2026','DD/MM/YYYY'),'2','2','43',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('44',to_date('15/01/2026','DD/MM/YYYY'),'2','2','44',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('45',to_date('15/01/2026','DD/MM/YYYY'),'3','2','45',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('46',to_date('15/01/2026','DD/MM/YYYY'),'3','2','46',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('47',to_date('15/01/2026','DD/MM/YYYY'),'3','2','47',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('48',to_date('15/01/2026','DD/MM/YYYY'),'3','2','48',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('49',to_date('15/01/2026','DD/MM/YYYY'),'1','4','49',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('50',to_date('15/01/2026','DD/MM/YYYY'),'1','4','50',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('51',to_date('15/01/2026','DD/MM/YYYY'),'1','4','51',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('52',to_date('15/01/2026','DD/MM/YYYY'),'2','4','52',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('53',to_date('15/01/2026','DD/MM/YYYY'),'3','4','53',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('54',to_date('15/01/2026','DD/MM/YYYY'),'3','4','54',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('55',to_date('15/01/2026','DD/MM/YYYY'),'3','4','55',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('56',to_date('15/01/2026','DD/MM/YYYY'),'3','4','56',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('57',to_date('15/01/2026','DD/MM/YYYY'),'2','5','57',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('58',to_date('15/01/2026','DD/MM/YYYY'),'2','5','58',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('59',to_date('15/01/2026','DD/MM/YYYY'),'2','5','59',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('60',to_date('15/01/2026','DD/MM/YYYY'),'2','5','60',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('61',to_date('15/01/2026','DD/MM/YYYY'),'3','5','61',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('62',to_date('15/01/2026','DD/MM/YYYY'),'3','5','62',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('63',to_date('15/01/2026','DD/MM/YYYY'),'3','5','63',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('64',to_date('15/01/2026','DD/MM/YYYY'),'3','5','64',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('65',to_date('15/01/2026','DD/MM/YYYY'),'2','6','65',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('66',to_date('15/01/2026','DD/MM/YYYY'),'2','6','66',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('67',to_date('15/01/2026','DD/MM/YYYY'),'2','6','67',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('68',to_date('15/01/2026','DD/MM/YYYY'),'2','6','68',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('69',to_date('15/01/2026','DD/MM/YYYY'),'3','6','69',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('70',to_date('15/01/2026','DD/MM/YYYY'),'3','6','70',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('71',to_date('15/01/2026','DD/MM/YYYY'),'3','6','71',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('72',to_date('15/01/2026','DD/MM/YYYY'),'3','6','72',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('73',to_date('15/01/2026','DD/MM/YYYY'),'2','7','73',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('74',to_date('15/01/2026','DD/MM/YYYY'),'2','7','74',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('75',to_date('15/01/2026','DD/MM/YYYY'),'2','7','75',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('76',to_date('15/01/2026','DD/MM/YYYY'),'2','7','76',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('77',to_date('15/01/2026','DD/MM/YYYY'),'3','7','77',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('78',to_date('15/01/2026','DD/MM/YYYY'),'3','7','78',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('79',to_date('15/01/2026','DD/MM/YYYY'),'3','7','79',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('80',to_date('15/01/2026','DD/MM/YYYY'),'3','7','80',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('81',to_date('15/01/2026','DD/MM/YYYY'),'2','8','81',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('82',to_date('15/01/2026','DD/MM/YYYY'),'2','8','82',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('83',to_date('15/01/2026','DD/MM/YYYY'),'2','8','83',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('84',to_date('15/01/2026','DD/MM/YYYY'),'2','8','84',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('85',to_date('15/01/2026','DD/MM/YYYY'),'3','8','85',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('86',to_date('15/01/2026','DD/MM/YYYY'),'3','8','86',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('87',to_date('15/01/2026','DD/MM/YYYY'),'3','8','87',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('88',to_date('15/01/2026','DD/MM/YYYY'),'3','8','88',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('89',to_date('15/01/2026','DD/MM/YYYY'),'2','9','89',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('90',to_date('15/01/2026','DD/MM/YYYY'),'2','9','90',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('91',to_date('15/01/2026','DD/MM/YYYY'),'2','9','91',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('92',to_date('15/01/2026','DD/MM/YYYY'),'2','9','92',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('93',to_date('15/01/2026','DD/MM/YYYY'),'3','9','93',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('94',to_date('15/01/2026','DD/MM/YYYY'),'3','9','94',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('95',to_date('15/01/2026','DD/MM/YYYY'),'3','9','95',null);
Insert into ACJJ_GRUPOS_LECTORES (ID_LECTOR,FECHA_INICIO,ID_GRUPO,ID_CLUB,ID_MEMBRESIA,FECHA_FIN) values ('96',to_date('15/01/2026','DD/MM/YYYY'),'3','9','96',null);
-- ============================================================
-- FIX 3: CALENDARIOS_MES — nombres reales de columna para moderador:
--   MOD_ID_LECTOR, MOD_FECHA_INICIO, MOD_ID_GRUPO, MOD_ID_CLUB,
--   MOD_ID_MEMBRESIA  (sin MOD_ID_CLUBG ni ID_MODERADOR separados)
-- ============================================================
-- 19. CALENDARIOS_MES (10)
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('3',to_date('07/03/2026','DD/MM/YYYY'),'1','9788490638743','N','9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9','N',null,null);
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('3',to_date('14/03/2026','DD/MM/YYYY'),'1','9788490638743','N','9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9','N',null,null);
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('3',to_date('21/03/2026','DD/MM/YYYY'),'1','9788490638743','S','9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9','S','Obra fundamental del feminismo venezolano.','5');
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('3',to_date('04/04/2026','DD/MM/YYYY'),'1','9780307389732','N','9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9','N',null,null);
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('3',to_date('11/04/2026','DD/MM/YYYY'),'1','9780307389732','S','9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9','S','Excelente debate sobre el amor.','4');
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('1',to_date('05/03/2026','DD/MM/YYYY'),'1','9781400334599','N','9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9','N',null,null);
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('1',to_date('12/03/2026','DD/MM/YYYY'),'1','9781400334599','S','9',to_date('15/01/2026','DD/MM/YYYY'),'3','1','9','S','A los ninos les encanto Narnia.','5');
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('2',to_date('06/03/2026','DD/MM/YYYY'),'1','9781423160915','N','5',to_date('15/01/2026','DD/MM/YYYY'),'2','1','5','N',null,null);
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('2',to_date('13/03/2026','DD/MM/YYYY'),'1','9781423160915','S','5',to_date('15/01/2026','DD/MM/YYYY'),'2','1','5','S','Mitologia nordica atractiva.','4');
Insert into ACJJ_CALENDARIOS_MES (ID_GRUPO,FECHA,ID_CLUB,ISBN_LIBRO,REALIZADO,MOD_ID_LECTOR,MOD_FECHA_INICIO,MOD_ID_GRUPO,MOD_ID_CLUB,MOD_ID_MEMBRESIA,ULT_REUNION,CONCLUSIONES,VALORACION) values ('1',to_date('03/04/2026','DD/MM/YYYY'),'2','9786071600004','S','13',to_date('15/01/2026','DD/MM/YYYY'),'1','2','13','S','Buena discusion sobre lo fantastico.','4');

-- ============================================================
-- FIX 4: INASISTENCIAS — columnas reales:
--   (ID_LECTOR, ID_CLUB, ID_GRUPO, CAL_FECHA, ID_MEMBRESIA, FECHA_INI_GL)
-- ============================================================
-- 20. INASISTENCIAS (9)
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('9','1','3',to_date('14/03/2026','DD/MM/YYYY'),'9',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('10','1','3',to_date('07/03/2026','DD/MM/YYYY'),'10',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('10','1','3',to_date('21/03/2026','DD/MM/YYYY'),'10',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('11','1','3',to_date('11/04/2026','DD/MM/YYYY'),'11',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('12','1','3',to_date('07/03/2026','DD/MM/YYYY'),'12',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('1','1','1',to_date('05/03/2026','DD/MM/YYYY'),'1',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('2','1','1',to_date('05/03/2026','DD/MM/YYYY'),'2',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('5','1','2',to_date('13/03/2026','DD/MM/YYYY'),'5',to_date('15/01/2026','DD/MM/YYYY'));
Insert into ACJJ_INASISTENCIAS (ID_LECTOR,ID_CLUB,ID_GRUPO,CAL_FECHA,ID_MEMBRESIA,FECHA_INI_GL) values ('6','1','2',to_date('06/03/2026','DD/MM/YYYY'),'6',to_date('15/01/2026','DD/MM/YYYY'));

-- ============================================================
-- FIX 5: OBRAS_TEATRALES — ESTATUS: 'A'=activa, 'I'=inactiva
-- ============================================================
-- 21. OBRAS_TEATRALES (9)
-- INSERTS CORREGIDOS ACJJ_OBRAS_TEATRALES
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (1,1,9788490638743,'A',10.5);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (1,2,9780307389732,'A',12.0);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (2,1,9786071600004,'A',15.0);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (4,1,9786071100238,'I',8.0);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (5,1,9780141439556,'A',11.0);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (6,1,9788483835043,'A',13.5);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (7,1,9788490638743,'A',9.0);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (8,1,9780451205766,'A',14.0);
Insert into ACJJ_OBRAS_TEATRALES (ID_CLUB,ID_OBRA,ISBN_LIBRO,ESTATUS,COSTO_ENTRADA) values (9,1,9780060535162,'A',10.0);
COMMIT;
-- 22. ELENCOS (9)
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('1','9','1','9788490638743');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('1','10','1','9788490638743');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('1','11','1','9788490638743');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('2','9','1','9780307389732');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('2','12','1','9780307389732');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('1','13','2','9786071600004');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('1','14','2','9786071600004');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('1','15','2','9786071600004');
Insert into ACJJ_ELENCOS (ID_OBRA,ID_ACTOR,ID_CLUB,ISBN_OBRA) values ('1','37','9','9780060535162');

-- ============================================================
-- FIX 6: PRESENTACIONES — columna real es ESTRELLAS_OBT
-- ============================================================
-- 23. PRESENTACIONES (9)
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','1',to_date('15/05/2026','DD/MM/YYYY'),'9788490638743','45','5');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','1',to_date('22/05/2026','DD/MM/YYYY'),'9788490638743','60','4');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('2','1',to_date('10/06/2026','DD/MM/YYYY'),'9780307389732','50','5');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','2',to_date('18/05/2026','DD/MM/YYYY'),'9786071600004','70','4');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','5',to_date('20/05/2026','DD/MM/YYYY'),'9780141439556','40','3');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','6',to_date('25/05/2026','DD/MM/YYYY'),'9788483835043','55','5');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','7',to_date('28/05/2026','DD/MM/YYYY'),'9788490638743','35','4');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','8',to_date('30/05/2026','DD/MM/YYYY'),'9780451205766','65','5');
Insert into ACJJ_PRESENTACIONES (ID_OBRA,ID_CLUB,FECHA,ISBN_LIB_OBRA,ENT_VENDIDAS,ESTRELLAS_OBT) values ('1','9',to_date('02/06/2026','DD/MM/YYYY'),'9780060535162','48','4');

-- ============================================================
-- FIX 7: MEJORES_ACTORES — estructura real (5 columnas):
--   FECHA_PRES, ID_ACTOR, ID_OBRA, ISBN, ID_CLUB
-- ============================================================
-- 24. MEJORES_ACTORES (9)
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('15/05/2026','DD/MM/YYYY'),'9','1','9788490638743','1');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('15/05/2026','DD/MM/YYYY'),'10','1','9788490638743','1');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('22/05/2026','DD/MM/YYYY'),'11','1','9788490638743','1');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('10/06/2026','DD/MM/YYYY'),'9','2','9780307389732','1');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('10/06/2026','DD/MM/YYYY'),'12','2','9780307389732','1');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('18/05/2026','DD/MM/YYYY'),'13','1','9786071600004','2');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('18/05/2026','DD/MM/YYYY'),'14','1','9786071600004','2');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('18/05/2026','DD/MM/YYYY'),'15','1','9786071600004','2');
Insert into ACJJ_MEJORES_ACTORES (FECHA_PRES,ID_ACTOR,ID_OBRA,ISBN,ID_CLUB) values (to_date('02/06/2026','DD/MM/YYYY'),'37','1','9780060535162','9');

COMMIT;
-- FIN — Scripts con columnas corregidas