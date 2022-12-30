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

/*
-- donaciones - futura implementacion:

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


-- gastos e ingresos - futura implementacion

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
*/
