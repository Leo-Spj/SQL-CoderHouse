-- tablas
DELIMITER ;
DROP DATABASE IF EXISTS nuevo_huellitas;
CREATE SCHEMA IF NOT EXISTS nuevo_huellitas;
USE nuevo_huellitas;

CREATE TABLE IF NOT EXISTS especies(
	codigo_especie INT NOT NULL UNIQUE AUTO_INCREMENT,
    especie VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_especie)
);
CREATE TABLE IF NOT EXISTS tamaño(
	codigo_tamaño INT NOT NULL UNIQUE AUTO_INCREMENT,
    tamaño VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_tamaño)
);
CREATE TABLE IF NOT EXISTS sexo(
	codigo_sexo INT NOT NULL UNIQUE AUTO_INCREMENT,
    sexo VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_sexo)
);
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
CREATE TABLE IF NOT EXISTS global_personas(
	dni INT NOT NULL UNIQUE,
    nombre  VARCHAR (50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
    
    PRIMARY KEY (dni)
);
CREATE TABLE IF NOT EXISTS residencia(
	dni INT NOT NULL,
    residencia VARCHAR(200),
    
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS emails(
	dni INT NOT NULL,
    email VARCHAR(200) UNIQUE DEFAULT NULL,
    
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS telefonos(
	dni INT NOT NULL,
    telefono VARCHAR(14) NOT NULL UNIQUE,
    
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS tipos_rolcargo(
	codigo_rolcargo INT NOT NULL UNIQUE AUTO_INCREMENT,
	rolcargo VARCHAR(30) NOT NULL UNIQUE,
    
    PRIMARY KEY (codigo_rolcargo)
);
CREATE TABLE IF NOT EXISTS personal(
	codigo_personal INT NOT NULL AUTO_INCREMENT,
    dni INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    
    PRIMARY KEY (codigo_personal),
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS rolescargos_personal(
	codigo_personal INT NOT NULL,
    codigo_rolcargo INT NOT NULL,
    
    FOREIGN KEY (codigo_personal) REFERENCES personal(codigo_personal) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codigo_rolcargo) REFERENCES tipos_rolcargo(codigo_rolcargo) ON DELETE CASCADE ON UPDATE CASCADE 
);
-- tabla de trigger:
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
CREATE TABLE IF NOT EXISTS adoptante(
	codigo_adopcion INT NOT NULL AUTO_INCREMENT UNIQUE,
    id_mascota INT NOT NULL UNIQUE,
    dni INT NOT NULL,
    fecha_adopcion DATE NOT NULL DEFAULT (CURRENT_DATE),
    
    PRIMARY KEY (codigo_adopcion),
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (dni) REFERENCES global_personas(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS observaciones_adoptante(
	codigo_adopcion INT NOT NULL,
    fecha_observacion DATE NOT NULL,
	descripcion VARCHAR(200),
    
    FOREIGN KEY (codigo_adopcion) REFERENCES adoptante(codigo_adopcion) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- FUNCIONES

-- crea funcion que entre por parametro fecha y retorne los años trascurridos: años_trascurridos
DROP FUNCTION IF EXISTS `años_transcurridos`;
DELIMITER $$
CREATE FUNCTION `años_transcurridos` (fecha date)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE años INT;
	SET años = year(curdate()) - year(fecha);
	RETURN años;
END$$

  
DROP FUNCTION IF EXISTS `meses_transcurridos`;
DELIMITER $$
USE `nuevo_huellitas`$$
CREATE FUNCTION  `meses_transcurridos` (fecha date)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE meses INT;
	SET meses = month(curdate()) - month(fecha);
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


-- VIEWS

USE nuevo_huellitas;

-- muestra los cuidadores que tienen mascotas en cuidado
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

-- muestra las mascotas que no tienen cuidador
CREATE OR REPLACE VIEW `mascotas_sin_cuidador`  AS
SELECT 
	M.id_mascota AS 'ID mascota',
    E.especie AS Especie,
	T.tamaño AS Tamaño,
    S.sexo AS Sexo,
    nombre AS "Nombre Mascota",
    tiempo_total(M.edad) AS 'Edad'
    
    FROM mascota AS M
    
    INNER JOIN especies AS E 	ON E.codigo_especie	 = M.codigo_especie
    INNER JOIN 	tamaño 	AS T 	ON 	T.codigo_tamaño	 = M.codigo_tamaño
    INNER JOIN 	sexo 	AS S 	ON 	S.codigo_sexo	 = M.codigo_sexo
    
    LEFT JOIN mascota_personal AS MP ON M.id_mascota = MP.id_mascota
    
    LEFT JOIN adoptante AS A ON M.id_mascota = A.id_mascota    
    
	WHERE MP.id_mascota IS NULL AND A.id_mascota IS NULL
    
	ORDER BY M.id_mascota ASC
;

CREATE OR REPLACE VIEW `Mascotas_totales_disponibles` AS
SELECT 
	M.id_mascota AS 'ID mascota',
	E.especie AS Especie, 
	M.nombre AS Nombre,
	T.tamaño AS Tamaño, 
	S.sexo AS Sexo,     
    -- mi funcion:
    tiempo_total(M.edad) AS 'Edad (por funcion)'
    
FROM mascota AS M

INNER JOIN especies AS E 	ON 	E.codigo_especie = M.codigo_especie
INNER JOIN tamaño 	AS T 	ON 	T.codigo_tamaño	 = M.codigo_tamaño
INNER JOIN sexo 	AS S 	ON 	S.codigo_sexo	 = M.codigo_sexo

WHERE M.cantidad = 1
ORDER BY M.edad DESC
;

-- muestra las perros disponibles para adopcion
CREATE OR REPLACE VIEW `Perros_disponibles` AS
SELECT 
	M.id_mascota AS 'ID mascota',
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

WHERE M.cantidad = 1 AND E.especie = "perro"
ORDER BY M.edad DESC
;

-- muestra las gatos disponibles para adopcion
CREATE OR REPLACE VIEW `Gatos_disponibles` AS
SELECT 
	M.id_mascota AS 'ID mascota',
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

WHERE M.cantidad = 1 AND E.especie = "gato"
ORDER BY M.edad DESC
;

-- muestra el regristro global de personas agrupados por dni
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



-- STORED PROCEDURE

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
        ORDER BY M.cantidad DESC;
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
        ORDER BY M.cantidad DESC;
	END IF;
END$$


DROP procedure IF EXISTS `ingresar_persona`$$
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
    
    IF (nombre_p <>'' OR apellido_p <>'' OR telefono_p <>'' OR residencia_p <>'') THEN
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


DROP PROCEDURE IF EXISTS `adopcion`$$
USE `nuevo_huellitas`$$
CREATE PROCEDURE `adopcion` (IN idMascota INT, IN dniPersona INT, IN fechaAdopcion DATE)
BEGIN
	INSERT INTO adoptante(id_mascota, dni, fecha_adopcion)
	VALUES (idMascota,dniPersona,fechaAdopcion);
END$$
DELIMITER ;



-- TRIGGERS

DELIMITER $$


CREATE TRIGGER `trg_eliminar-mascotaPersonal`
AFTER DELETE ON mascota_personal 
FOR EACH ROW
BEGIN
	INSERT INTO trg_cuidadores_historial(id_mascota, codigo_personal, fecha_asignada, fecha_adoptado)
    VALUES (OLD.id_mascota, OLD.codigo_personal, OLD.fecha_asignada, CURDATE());
END$$

CREATE TRIGGER `trg_adopcion`
AFTER INSERT ON adoptante 
FOR EACH ROW
BEGIN
	UPDATE mascota
    SET cantidad = IF(cantidad >= 1, cantidad - 1, 0) 
    WHERE id_mascota = NEW.id_mascota;
END$$

CREATE TRIGGER `trg_deslisde_mascota-personal`
AFTER UPDATE ON mascota 
FOR EACH ROW
BEGIN
	IF (NEW.cantidad < 1) THEN
		DELETE FROM mascota_personal
        WHERE id_mascota = NEW.id_mascota;
	END IF;
END$$


DELIMITER ;