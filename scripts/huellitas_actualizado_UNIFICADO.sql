

DELIMITER ;
DROP DATABASE IF EXISTS nuevo_huellitas;
CREATE SCHEMA IF NOT EXISTS nuevo_huellitas;

USE nuevo_huellitas;

-- crea funcion que entre por parametro fecha y retorne los años trascurridos: años_trascurridos
DROP FUNCTION IF EXISTS `años_transcurridos`;
DELIMITER $$
CREATE FUNCTION `años_transcurridos` (fecha date)
returns int
deterministic
begin
declare años int;
set años = year(curdate()) - year(fecha);
return años;

end$$

  
DROP FUNCTION IF EXISTS `meses_transcurridos`;
DELIMITER $$
USE `nuevo_huellitas`$$
CREATE FUNCTION  `meses_transcurridos` (fecha date)
returns int
deterministic
begin
declare meses int;
set meses = month(curdate()) - month(fecha);
return meses;
END$$


DROP FUNCTION IF EXISTS `tiempo_total`;
DELIMITER $$
USE `nuevo_huellitas`$$
CREATE FUNCTION `tiempo_total` (fecha DATE)
RETURNS VARCHAR(50)
READS SQL DATA
BEGIN
	DECLARE cadena VARCHAR(50);
    
    DECLARE año INT;
    DECLARE cadena_año VARCHAR(20);    
    DECLARE meses INT;
    DECLARE cadena_meses VARCHAR(20);
    
    SET año = años_transcurridos(fecha);
	
    IF (año = 0) THEN
		SET cadena_año = '';
	ELSE 
		SET cadena_año = CONCAT(año, ' años ');
	END IF;
    
    
    SET meses = meses_transcurridos(fecha);
	
    IF (meses < 0) THEN
        SET año = años_transcurridos(fecha) - 1;
        SET cadena_año = CONCAT(año, ' años ');
        
			IF (año <= 0) THEN
			SET cadena_año = '';
			END IF;
        
        SET meses = 12 + meses_transcurridos(fecha);
        SET cadena_meses = CONCAT(meses, ' meses ');
    END IF;  
    
	IF (meses = 0) THEN
		SET cadena_meses = '';
	ELSE
		SET cadena_meses = CONCAT(meses, ' meses ');
	END IF;    
    
    SET cadena = CONCAT(cadena_año, cadena_meses);

RETURN cadena;
END$$






DELIMITER ;

CREATE TABLE IF NOT EXISTS especies(
	codigo_especie INT NOT NULL UNIQUE AUTO_INCREMENT,
    especie VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_especie)
);
INSERT INTO especies(especie)
VALUES
 ('perro'),
 ('gato')
;
CREATE TABLE IF NOT EXISTS tamaño(
	codigo_tamaño INT NOT NULL UNIQUE AUTO_INCREMENT,
    tamaño VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_tamaño)
);
INSERT INTO tamaño(tamaño)
VALUES
 ('pequeño'),
 ('mediano'),
 ('grande')
;

CREATE TABLE IF NOT EXISTS sexo(
	codigo_sexo INT NOT NULL UNIQUE AUTO_INCREMENT,
    sexo VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_sexo)
);
INSERT INTO sexo
VALUES
 (1,'macho'),
 (2,'hembra')
 ;


CREATE TABLE IF NOT EXISTS mascota(
	id_mascota INT NOT NULL AUTO_INCREMENT,
    cantidad INT DEFAULT 1,
    fecha_ingreso DATE NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    edad DATE,
    codigo_especie INT NOT NULL,
    codigo_tamaño INT NOT NULL,
    codigo_sexo INT NOT NULL,
    
    PRIMARY KEY (id_mascota),
    FOREIGN KEY (codigo_especie) 
		REFERENCES especies(codigo_especie) 
        ON DELETE RESTRICT 
        ON UPDATE RESTRICT,
    FOREIGN KEY (codigo_tamaño) 
		REFERENCES tamaño(codigo_tamaño) 
        ON DELETE RESTRICT 
        ON UPDATE RESTRICT,
    FOREIGN KEY (codigo_sexo) 
		REFERENCES sexo(codigo_sexo) 
		ON DELETE RESTRICT 
		ON UPDATE RESTRICT
);
INSERT INTO mascota(fecha_ingreso, nombre, edad, codigo_especie, codigo_tamaño, codigo_sexo)
VALUES
('2021-01-30','Hondger','2013-12-24',1,2,1),
('2021-01-30','Burlek','2016-12-28',1,2,2),
('2021-02-20','Litdove','2020-12-31',1,3,1),
('2021-03-05','Liosea','2014-03-28',2,2,2),
('2021-08-20','Helineal','2018-04-14',2,1,2),
('2021-09-30','Lared','2016-11-17',1,2,1),
('2021-10-22','Monkeart','2011-04-04',2,1,1),
('2022-01-04','Galalion','2019-05-20',2,1,1),
('2022-02-12','Lizariny','2020-09-02',2,3,1),
('2022-03-04','Roset','2019-06-20',1,3,2),
('2022-03-06','Woogeon','2021-12-07',1,3,1),
('2022-05-29','Lavull','2015-08-27',1,2,2),
('2022-08-20','Eastatictor','2022-05-11',1,3,1),
('2022-10-23','Ojeloto','2019-03-14',1,2,2),
('2022-10-26','Herilled','2019-08-01',1,1,1)
;

CREATE TABLE IF NOT EXISTS global_personas(
	dni INT NOT NULL UNIQUE,
    nombre  VARCHAR (50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
    
    PRIMARY KEY (dni)
);
INSERT INTO global_personas(dni,nombre,apellido)
VALUES
(10000000,'HUELLITAS AGRUPACION ESTUDIANTIL', 'HUELLITAS AGRUPACION ESTUDIANTIL'),
(77827980,'Janaye','Malshinger'),
(80772770,'Michaella','Knightsbridge'),
(68191408,'Tadio','Heugle'),
(72506704,'Letti','Ogborne'),
(72919941,'Taber','Warin'),
(83315590,'Lanie','Manuel'),
(60831369,'Brad','Brimacombe'),
(66050557,'Jennilee','Ismay'),
(67984382,'Gaile','Barbier'),
(67124542,'Myrtie','Wensley'),
(79654984,'Judith','McGraw'),
(71036485,'Nikki','Moss'),
(88250405,'Leanor','Iacobassi'),
(85498508,'Nial','Muris'),
(76120720,'Kenneth','Kirvin'),
(77407813,'Piggy','Niblett'),
(84537439,'Jaime','Maybey'),
(82557035,'Katee','Hadland'),
(78560458,'Rennie','Coysh'),
(84652514,'Maryjo','Olivera')
;

CREATE TABLE IF NOT EXISTS residencia(
	dni INT NOT NULL,
    residencia VARCHAR(200),
    
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO residencia
VALUES
(10000000,'Universidad Nacional Agraria la Molina'),
(77827980,'393 Golden Leaf Avenue'),
(80772770,'9 Di Loreto Way'),
(68191408,'9861 Fair Oaks Plaza'),
(72506704,'18 Barnett Way'),
(72919941,'3 Brickson Park Terrace'),
(83315590,'51354 Westport Park'),
(60831369,'894 Ludington Alley'),
(66050557,'73 Dexter Point'),
(67984382,'377 Monument Pass'),
(67124542,'1 Springview Avenue'),
(79654984,'787 Gina Parkway'),
(71036485,'55 Veith Parkway'),
(88250405,'65919 Susan Street'),
(85498508,'80067 Pearson Court'),
(76120720,'2 Westridge Circle'),
(77407813,'082 Annamark Alley'),
(84537439,'471 Dwight Trail'),
(82557035,'2679 Veith Junction'),
(78560458,'6 Nelson Avenue'),
(84652514,'0 Anhalt Plaza'),
(72506704,'99 Corry Drive'),
(66050557,'40382 Annamark Drive'),
(85498508,'46736 Fair Oaks Plaza')
;

CREATE TABLE IF NOT EXISTS emails(
	dni INT NOT NULL,
    email VARCHAR(200) UNIQUE DEFAULT NULL,
    
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO emails
VALUES
(10000000,'agrupacionestudiantil_huellitas@gmail.com'),
(77827980,'njosowitz0@google.ca'),
(80772770,'mduffie1@wp.com'),
(68191408,'drustman2@yandex.ru'),
(72506704,'mcarlucci3@ehow.com'),
(72919941, NULL ),
(83315590,'btiffin5@google.com'),
(60831369,'grosen6@mediafire.com'),
(66050557,'dlorkins7@independent.co.uk'),
(67984382,'rbrownsmith8@hatena.ne.jp'),
(67124542,'bcarlisso9@amazon.co.jp'),
(79654984,'ccaldowa@ed.gov'),
(71036485,'bfearnallb@privacy.gov.au'),
(88250405,'agorstidgec@stanford.edu'),
(85498508,'wspeddind@google.com'),
(76120720,'asilvermanne@businesswire.com'),
(77407813,'phatherillf@eventbrite.com'),
(84537439,'kgianninottig@gravatar.com'),
(82557035,'hfownesh@webs.com'),
(78560458,'rquesnei@chron.com'),
(84652514,'awedlockj@qq.com'),
(77827980,'bmanthak@paypal.com'),
(68191408,'tbellanyl@tripod.com'),
(66050557,'mpitchersm@wikimedia.org'),
(71036485,'bgulstonn@nba.com'),
(84537439,'rcollyo@dyndns.org'),
(82557035,'clarrawayp@senate.gov'),
(78560458,'tbeynkeq@time.com'),
(80772770,'cmccannyr@discuz.net'),
(83315590,'trhymess@marriott.com'),
(76120720,'mdyet@telegraph.co.uk'),
(80772770,'mjenickeu@behance.net'),
(83315590,'byushinv@nymag.com'),
(76120720,'sheaysmanw@berkeley.edu')
;

CREATE TABLE IF NOT EXISTS telefonos(
	dni INT NOT NULL,
    telefono VARCHAR(14) NOT NULL UNIQUE,
    
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO telefonos
VALUES
(10000000,'456-456'),
(77827980,'9106361487'),
(80772770,'1294910651'),
(68191408,'1868639781'),
(72506704,'9184590549'),
(72919941,'4608888551'),
(83315590,'4474346985'),
(60831369,'8401225283'),
(66050557,'8202495164'),
(67984382,'8119603265'),
(67124542,'2934820147'),
(79654984,'5727739378'),
(71036485,'2542825858'),
(88250405,'7862842111'),
(85498508,'6232596077'),
(76120720,'6309666170'),
(77407813,'2034521136'),
(84537439,'1765717693'),
(82557035,'6045500240'),
(78560458,'2363390949'),
(84652514,'1169586750'),
(77827980,'6453782827'),
(80772770,'2394504180'),
(83315590,'7248672533'),
(67124542,'8915595738'),
(71036485,'6665560510'),
(82557035,'3507495300'),
(84652514,'4596570754'),
(68191408,'8172792892'),
(72919941,'8852098951'),
(85498508,'2079743874'),
(68191408,'8097640505'),
(72919941,'7834502043'),
(85498508,'8806942892')
;
CREATE TABLE IF NOT EXISTS tipos_rolcargo(
	codigo_rolcargo INT NOT NULL UNIQUE AUTO_INCREMENT,
	rolcargo VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_rolcargo)
);
INSERT INTO tipos_rolcargo(rolcargo)
VALUES
('albergue'),
('cuidador'),
('administrador'),
('logistica'),
('recursos humanos'),
('contabilidad'),
('secretaria'),
('coordinador')
;

CREATE TABLE IF NOT EXISTS personal(
	codigo_personal INT NOT NULL AUTO_INCREMENT,
    dni INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    
    PRIMARY KEY (codigo_personal),
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO personal(dni, fecha_inicio)
VALUES
(80772770,'2020-10-30'),
(83315590,'2020-10-30'),
(71036485,'2020-11-05'),
(79654984,'2020-11-15'),
(67124542,'2020-11-30'),
(76120720,'2021-02-04'),
(82557035,'2021-02-04')
;

CREATE TABLE IF NOT EXISTS rolescargos_personal(
	codigo_personal INT NOT NULL,
    codigo_rolcargo INT NOT NULL,
    
    FOREIGN KEY (codigo_personal) REFERENCES personal(codigo_personal) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codigo_rolcargo) REFERENCES tipos_rolcargo(codigo_rolcargo) ON DELETE CASCADE ON UPDATE CASCADE 
);
INSERT INTO rolescargos_personal
VALUES
(1,5),
(1,7),
(2,3),
(2,6),
(3,4),
(3,8),
(4,2),
(5,2),
(6,2),
(7,2)
;

-- TABLA PARA TRIGGER:
CREATE TABLE IF NOT EXISTS trg_cuidadores_historial(
	id_mascota INT NOT NULL UNIQUE,
    codigo_personal INT NOT NULL,
    fecha_asignada DATE NOT NULL,
    fecha_adoptado DATE NOT NULL DEFAULT (curdate()),
    
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (codigo_personal) REFERENCES personal(codigo_personal) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS mascota_personal(
	id_mascota INT NOT NULL,
    codigo_personal INT NOT NULL,
    fecha_asignada DATE NOT NULL,
    
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codigo_personal) REFERENCES personal(codigo_personal) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO mascota_personal
VALUES
(7,4,'2020-11-17'),
(1,5,'2020-12-02'),
(4,6,'2021-02-06'),
(12,7,'2021-02-06')
;
CREATE OR REPLACE VIEW `cuidadores_con_mascotas`  AS
SELECT 
	M.id_mascota AS 'ID Mascota',
    E.especie AS Especie,
    M.nombre AS Mascota,
    S.sexo AS Sexo,
    P.codigo_personal AS 'Codigo del Personal',
    GP.dni AS  'DNI Cuidador',
    CONCAT(GP.nombre," ",GP.apellido) AS 'Nombre cuidador'
    
    FROM mascota_personal AS MP
    
    INNER JOIN mascota AS M ON M.id_mascota = MP.id_mascota
    INNER JOIN especies AS E ON E.codigo_especie = M.codigo_especie
    INNER JOIN sexo AS S ON S.codigo_sexo = M.codigo_sexo
    INNER JOIN personal AS P ON P.codigo_personal = MP.codigo_personal
    INNER JOIN global_personas AS GP ON GP.dni = P.dni
     
     ORDER BY M.id_mascota ASC
;

CREATE TABLE IF NOT EXISTS adoptante(
	codigo_adopcion INT NOT NULL AUTO_INCREMENT UNIQUE,
    id_mascota INT NOT NULL UNIQUE,
    dni INT NOT NULL,
    fecha_adopcion DATE NOT NULL DEFAULT (CURRENT_DATE),
    
    PRIMARY KEY (codigo_adopcion),
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO adoptante(id_mascota, dni, fecha_adopcion)
VALUES
(2,68191408,'2021-04-30'),
(3,84537439,'2021-09-20'),
(5,72506704,'2021-10-20'),
(6,77827980,'2021-10-30'),
(11,78560458,'2022-04-06'),
(10,66050557,'2022-06-04'),
(8,60831369,'2022-07-04'),
(9,85498508,'2022-08-12'),
(13,84652514,'2022-10-20'),
(15,88250405,'2022-11-11'),
(14,72919941,'2022-11-23')
;

CREATE TABLE IF NOT EXISTS observaciones_adoptante(
	codigo_adopcion INT NOT NULL,
    fecha_observacion DATE NOT NULL,
	descripcion VARCHAR(200),
    
    FOREIGN KEY (codigo_adopcion) REFERENCES adoptante(codigo_adopcion) ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO observaciones_adoptante
VALUES
(7,'2022-11-03','La mascota fue dejada sin alimento tras irse de viaje un dia. La mascota está bien. Le hicimos una llamada de atencion.')
;

CREATE TABLE IF NOT EXISTS rucs(
	ruc INT NOT NULL UNIQUE,
    nombre_asociado VARCHAR(200) NOT NULL UNIQUE,
    
    PRIMARY KEY (ruc) 
);

CREATE TABLE IF NOT EXISTS categoria_donacion(
	codigo_tipo_donacion INT NOT NULL UNIQUE,
    tipo_donacion VARCHAR(200) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_tipo_donacion) 
);

CREATE TABLE IF NOT EXISTS donante(
	codigo_aporte INT NOT NULL UNIQUE AUTO_INCREMENT,
    fecha DATE NOT NULL,
    dni INT,
    ruc INT,
    codigo_tipo_donacion INT NOT NULL,
    
    PRIMARY KEY (codigo_aporte),    
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (ruc) REFERENCES  rucs(ruc) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (codigo_tipo_donacion) REFERENCES categoria_donacion(codigo_tipo_donacion) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS tipo_gasto(
	codigo_gasto INT NOT NULL AUTO_INCREMENT UNIQUE,
    tipo VARCHAR(200) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_gasto) 
);

CREATE TABLE IF NOT EXISTS gastos(
	id_gastos INT NOT NULL AUTO_INCREMENT UNIQUE,
    fecha DATE NOT NULL,
    tipo INT NOT NULL,
    descripcion VARCHAR(200),
    cantidad_gasto INT NOT NULL,
    
    PRIMARY KEY (id_gastos),    
    FOREIGN KEY (tipo) REFERENCES tipo_gasto(codigo_gasto) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS tipo_actividad(
	codigo_actividad INT NOT NULL AUTO_INCREMENT UNIQUE,
    tipo VARCHAR(200) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_actividad) 
);

CREATE TABLE IF NOT EXISTS actividades_eventos(
	id_actividad INT NOT NULL AUTO_INCREMENT UNIQUE,
    fecha_fin DATE NOT NULL,
    tipo_actividad INT NOT NULL,
    descripcion VARCHAR(200),
    ingreso INT NOT NULL,
    
    PRIMARY KEY (id_actividad),    
    FOREIGN KEY (tipo_actividad) REFERENCES tipo_actividad(codigo_actividad) ON DELETE RESTRICT ON UPDATE RESTRICT
);





CREATE OR REPLACE VIEW `Mascotas_disponibles` AS
SELECT 
	M.cantidad AS Disponibilidad, 
	E.especie AS Especie, 
	M.nombre AS Nombre,
	T.tamaño AS Tamaño, 
	S.sexo AS Sexo,     
    -- mi funcion:
    tiempo_total(M.edad) AS 'Edad (por funcion)'
    
FROM mascota AS M

INNER JOIN 	especies AS E 	ON 	E.codigo_especie = M.codigo_especie
INNER JOIN 	tamaño 	AS T 	ON 	T.codigo_tamaño	 = M.codigo_tamaño
INNER JOIN 	sexo 	AS S 	ON 	S.codigo_sexo	 = M.codigo_sexo

ORDER BY M.edad DESC
;


CREATE OR REPLACE VIEW `personas_datosCompletos` AS
SELECT 
	G.dni AS DNI,
	G.nombre AS Nombre,
	G.apellido AS Apellido,
	T.telefono AS Telefono,
	E.email AS "e-mail",
	R.residencia AS Direccion
    
    FROM global_personas AS G
    
    INNER JOIN telefonos AS T ON T.dni = G.dni
    INNER JOIN emails AS E ON E.dni = G.dni
    INNER JOIN residencia AS R ON R.dni = G.dni
    
    GROUP BY G.dni
    ORDER BY G.apellido asc
;







DROP PROCEDURE IF EXISTS `disponibles_x_especie`;
DELIMITER $$
USE `nuevo_huellitas`$$
CREATE PROCEDURE `disponibles_x_especie` (IN tipo_especie VARCHAR(20))
BEGIN
	IF (tipo_especie = 'perro') THEN
		SELECT 	M.cantidad AS Disponibilidad, 
				E.especie AS Especie, 
				M.nombre AS Nombre,
				tamaño AS Tamaño, 
				sexo AS Sexo,
                tiempo_total(M.edad) AS 'Edad (por funcion)'
		FROM mascota AS M
		INNER JOIN 	especies AS E 	ON 	E.codigo_especie = M.codigo_especie
		INNER JOIN 	tamaño 	AS T 	ON 	T.codigo_tamaño	 = M.codigo_tamaño
		INNER JOIN 	sexo 	AS S 	ON 	S.codigo_sexo	 = M.codigo_sexo
		WHERE E.codigo_especie = (
			SELECT codigo_especie 
			FROM especies 
			WHERE codigo_especie = 1)
        ORDER BY M.edad DESC;
	END IF;
    
	IF (tipo_especie = 'gato') THEN
		SELECT 	M.cantidad AS Disponibilidad, 
				E.especie AS Especie, 
				M.nombre AS Nombre,
				tamaño AS Tamaño, 
				sexo AS Sexo,
                tiempo_total(M.edad) AS 'Edad (por funcion)'
		FROM mascota AS M
		INNER JOIN 	especies AS E 	ON 	E.codigo_especie = M.codigo_especie
		INNER JOIN 	tamaño 	AS T 	ON 	T.codigo_tamaño	 = M.codigo_tamaño
		INNER JOIN 	sexo 	AS S 	ON 	S.codigo_sexo	 = M.codigo_sexo
		WHERE E.codigo_especie = (
		SELECT codigo_especie 
		FROM especies 
        WHERE codigo_especie = 2)
        ORDER BY M.edad DESC;
	END IF;
END$$
DELIMITER ;
-- CALL disponibles_x_especie('gato');
-- CALL disponibles_x_especie('perro');




DROP procedure IF EXISTS `ingresar_persona`;
DELIMITER $$
USE `nuevo_huellitas`$$
CREATE PROCEDURE `ingresar_persona` (
	IN dni_p INTEGER, 
	IN nombre_p VARCHAR(20), 
	IN apellido_p VARCHAR(50), 
	IN telefono_p VARCHAR(11),
    IN email_p VARCHAR(60),
    IN residencia_p VARCHAR(200))
BEGIN	

	IF (email_p = '') THEN
		SET email_p = NULL;
	END IF;
    
    IF (nombre_p <>'' || apellido_p <>'' || telefono_p <>'' || residencia_p <>'') THEN
		INSERT INTO global_personas
		VALUES (dni_p, nombre_p, apellido_p);

		INSERT INTO telefonos
		VALUES (dni_p, telefono_p);
			
		INSERT INTO emails
		VALUES (dni_p, email_p);
		
		INSERT INTO residencia
		VALUES (dni_p, residencia_p);
	
-- Alerta aqui!! averiguar

	END IF;
    
    
	
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS `adopcion`;
DELIMITER $$
USE `nuevo_huellitas`$$
CREATE PROCEDURE `adopcion` (IN idMascota INT, IN dniPersona INT, IN fechaAdopcion DATE)
BEGIN
	INSERT INTO adoptante(id_mascota, dni, fecha_adopcion)
	VALUES (idMascota,dniPersona,fechaAdopcion);
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER `trg_eliminar-mascotaPersonal`
AFTER DELETE ON mascota_personal 
FOR EACH ROW
BEGIN
	INSERT INTO trg_cuidadores_historial(id_mascota, codigo_personal, fecha_asignada, fecha_adoptado)
    VALUES (OLD.id_mascota, OLD.codigo_personal, OLD.fecha_asignada, CURDATE());
END$$
DELIMITER ;















