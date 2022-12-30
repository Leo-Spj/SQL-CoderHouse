-- stored procedure

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