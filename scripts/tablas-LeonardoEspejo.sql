
CREATE SCHEMA IF NOT EXISTS `huellitas_centro_adopcion` ;

USE huellitas_centro_adopcion;

-- 1 
CREATE TABLE IF NOT EXISTS mascota (
    id_mascota INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    especie VARCHAR(5) NOT NULL,
    tamaño VARCHAR(7),
    edad DATE,
    genero VARCHAR (1) NOT NULL,
    
    PRIMARY KEY (id_mascota)
);

-- 2
CREATE TABLE IF NOT EXISTS personas_registro_global(
	dni INT NOT NULL ,
    nombres  VARCHAR (50) NOT NULL,
    apellidos VARCHAR (50) NOT NULL,
    telefono VARCHAR(11),
    email VARCHAR(60),
    residencia VARCHAR (150) NOT NULL,
    
    PRIMARY KEY (dni)
);

-- 3
CREATE TABLE IF NOT EXISTS mascota_asignada_personal(
	id_mascota INT NOT NULL,    
    fecha_asignada DATE NOT NULL,
    dni INT NOT NULL,
    
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (dni) REFERENCES personas_registro_global(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 4
CREATE TABLE IF NOT EXISTS adoptante(
	dni INT NOT NULL,
    id_mascota INT NOT NULL, 
    descripcion VARCHAR(200),
    fecha_adopcion DATE NOT NULL,
    
    FOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (dni) REFERENCES personas_registro_global(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 5
CREATE TABLE IF NOT EXISTS donante(
	codigo_aporte INT NOT NULL AUTO_INCREMENT,
    dni INT,
    ruc INT,
    fecha DATE NOT NULL,
    tipo VARCHAR(5),
    cantidad DECIMAL(7,2),
    descripcion VARCHAR(200),
    
    PRIMARY KEY (codigo_aporte),
    FOREIGN KEY (dni) REFERENCES personas_registro_global(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 6
CREATE TABLE IF NOT EXISTS personal(
	dni INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    descripcion_cargo_rol VARCHAR(100),
    
    FOREIGN KEY (dni) REFERENCES personas_registro_global(dni) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 7
CREATE TABLE IF NOT EXISTS tipo_actividad(
	codigo_actividad INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(15) NULL,
    
    PRIMARY KEY (codigo_actividad)
);

CREATE TABLE IF NOT EXISTS actividades_eventos(
	id_actividad INT NOT NULL AUTO_INCREMENT,
    fecha_fin DATE NOT NULL,
    tipo_actividad INT NOT NULL,
    descripcion VARCHAR(150),
    ingreso DECIMAL(7,2) NOT NULL,
    
    PRIMARY KEY (id_actividad),
    FOREIGN KEY (tipo_actividad) REFERENCES tipo_actividad(codigo_actividad) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 8
CREATE TABLE IF NOT EXISTS tipo_gasto(
	codigo_gasto INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(15) NULL,
    
    PRIMARY KEY (codigo_gasto)
);
CREATE TABLE IF NOT EXISTS gastos(
	id_gastos INT NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    tipo INT NOT NULL,
    descripcion VARCHAR(150),
    cantidad_gasto DECIMAL(7,2) NOT NULL,
    
    PRIMARY KEY (id_gastos),
    FOREIGN KEY (tipo) REFERENCES tipo_gasto(codigo_gasto)
);


-- 9
CREATE TABLE IF NOT EXISTS total_fondos(
	id_gastos INT,
    id_actividad INT,
    codigo_aporte INT,
    
    FOREIGN KEY (id_gastos) REFERENCES gastos(id_gastos),
    FOREIGN KEY (id_actividad) REFERENCES actividades_eventos(id_actividad),
    FOREIGN KEY (codigo_aporte) REFERENCES donante(codigo_aporte)
);



    
    
    
    
    