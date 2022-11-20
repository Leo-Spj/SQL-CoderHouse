-- views
USE nuevo_huellitas;

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