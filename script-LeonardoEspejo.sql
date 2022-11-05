
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


INSERT INTO tipo_actividad (tipo)
VALUES
	('Tombola'),
    ('Rifa'),
    ('Sorteo'),
    ('Bingo')
;
INSERT INTO tipo_gasto(tipo)
VALUES
	('alimento'),
    ('vaterinario'),
    ('otros')
;

INSERT INTO mascota(nombre, especie, tamaño, edad, genero) 
VALUES 
('mascota1', 'perro', 'pequeño', '2010-01-01', 'm'),
('mascota2', 'perro', 'mediano', '2011-01-01', 'm'),
('mascota3', 'perro', 'grande', '2012-01-01', 'm'),
('mascota4', 'perro', 'pequeño', '2013-01-01', 'm'),
('mascota5', 'perro', 'mediano', '2014-01-01', 'm'),
('mascota6', 'perro', 'grande', '2015-01-01', 'm'),
('mascota7', 'perro', 'pequeño', '2016-01-01', 'm'),
('mascota8', 'perro', 'mediano', '2017-01-01', 'm'),
('mascota9', 'perro', 'grande', '2018-01-01', 'm'),
('mascota10', 'perro', 'pequeño', '2019-01-01', 'm'),
('mascota11', 'gato', 'pequeño', '2010-01-01', 'h'),
('mascota12', 'gato', 'mediano', '2011-01-01', 'h'),
('mascota13', 'gato', 'grande', '2012-01-01', 'h'),
('mascota14', 'gato', 'pequeño', '2013-01-01', 'h'),
('mascota15', 'gato', 'mediano', '2014-01-01', 'h')
;


-- agregando datos de prueva a la tabla personas_registro_global:
INSERT INTO personas_registro_global(dni, nombres, apellidos, telefono, email, residencia)
VALUES
(2470073,'Chrystel','Ratnege','1411682462','cratnege0@icq.com','543 Kenwood Plaza'),
(8955536,'Fleming','Newnham','9886797769','fnewnham1@disqus.com','36 Meadow Vale Place'),
(9722528,'Sheba','Vinson','1502706251','svinson2@sun.com','5457 Dakota Court'),
(3683040,'Marcelline','Ferraron','2304646382','mferraron3@toplist.cz','16204 Orin Hill'),
(3164743,'Aloysia','Botting','7696481571','abotting4@jiathis.com','98 Sullivan Alley'),
(2776552,'Lennard','Pentycross','7218450099','lpentycross5@thetimes.co.uk','66 Hoard Junction'),
(5755055,'Simone','Suttaby','4866094426','ssuttaby6@amazonaws.com','6 Huxley Point'),
(5770067,'Kaycee','Berryann','2049192403','kberryann7@ucoz.com','28139 Dorton Road'),
(5847898,'Hanny','Haburne','5347846111','hhaburne8@linkedin.com','78 Welch Point'),
(9129076,'Samuele','Slimm','1439746934','sslimm9@surveymonkey.com','4945 Raven Trail'),
(8199783,'Delmer','Whittock','3887063778','dwhittocka@com.com','513 Straubel Hill'),
(6796601,'Etienne','Allwood','5256169694','eallwoodb@mysql.com','0844 Gale Point'),
(7797032,'Honoria','Pinchon','7972725293','hpinchonc@cnn.com','779 Duke Parkway'),
(1921567,'Darlene','Yegorshin','6183671243','dyegorshind@bloglovin.com','5 Ryan Alley'),
(9749036,'Raoul','Toulch','3866801714','rtoulche@blogspot.com','3227 Eastwood Place'),
(8092864,'Lurlene','Nichols','2148154144','lnicholsf@uol.com.br','9 Columbus Lane'),
(7743662,'Sully','Monini','8331689702','smoninig@nba.com','7171 Parkside Hill'),
(2609996,'Megen','Good','4598754397','mgoodh@cbc.ca','3403 Golden Leaf Drive'),
(8959831,'Gizela','Offa','5664237137','goffai@bbb.org','11609 Grim Plaza'),
(3018497,'Mikkel','Drugan','4456415733','mdruganj@state.gov','62694 Magdeline Drive'),
(2396582,'Brandea','Huonic','7913353703','bhuonick@techcrunch.com','41275 Brentwood Crossing'),
(7392976,'Gustie','Vicary','5589513324','gvicaryl@nps.gov','9166 Village Plaza'),
(1090361,'Patin','Rubes','7257879390','prubesm@amazonaws.com','207 Maple Wood Way'),
(5430910,'Eberhard','Berendsen','4281763052','eberendsenn@amazon.co.jp','75 Katie Parkway'),
(2686573,'Obediah','Stonier','3591797796','ostoniero@webeden.co.uk','7 Union Plaza'),
(4428337,'Ameline','Radleigh','8811714477','aradleighp@about.me','1038 Veith Court'),
(5640447,'Bentlee','Laurenz','2539601380','blaurenzq@eventbrite.com','3 Bluestem Trail'),
(7655076,'Keary','Reisenberg','6604048861','kreisenbergr@so-net.ne.jp','28 Fallview Trail'),
(6020593,'Dinah','Dicte','3822931108','ddictes@ucoz.ru','21618 Johnson Hill'),
(7534799,'Ellissa','Quilligan','4286482156','equilligant@census.gov','19888 Dapin Parkway'),
(7326757,'Wileen','Chafer','1247200987','wchaferu@time.com','74310 Mcguire Terrace'),
(4361265,'Flossy','Kane','1152567040','fkanev@hibu.com','811 Magdeline Street'),
(7710088,'Herve','Gawith','9422343423','hgawithw@epa.gov','847 Aberg Drive'),
(7900668,'Karleen','Keson','9492504290','kkesonx@japanpost.jp','4 Valley Edge Place'),
(4169439,'Karyl','Gamlin','3616574001','kgamliny@canalblog.com','28 Mosinee Point'),
(8935089,'Andros','Arnoll','9964598359','aarnollz@squarespace.com','21525 Mccormick Place'),
(7993893,'Clerc','Miles','1461632806','cmiles10@dailymotion.com','9357 Mandrake Way'),
(9096013,'Lorain','Cockshot','4005102428','lcockshot11@drupal.org','967 Spaight Road'),
(3479285,'Vivyanne','Hatje','8722753462','vhatje12@hud.gov','3 Fremont Pass'),
(5002249,'Matty','Baumler','4116979667','mbaumler13@etsy.com','85 Logan Place')
;

-- agregando datos a la tabla de gastos:
INSERT INTO gastos(fecha, tipo, descripcion, cantidad_gasto)
VALUES
('21-11-28',2,'',213.62),
('22-03-02',1,'',874.02),
('22-10-10',1,'jdjalgbkja-skjdasd',367.04),
('22-09-25',2,'jdjalgbkja-skjdasd',72.06),
('22-09-19',3,'',376.7),
('22-06-10',2,'jdjalgbkja-skjdasd',785.18),
('22-05-02',3,'jdjalgbkja-skjdasd',275.45),
('22-08-05',1,'',268.46),
('22-01-27',3,'',770.7),
('22-02-12',1,'',93.68),
('22-06-10',1,'jdjalgbkja-skjdasd',37.16),
('22-08-16',3,'',799.69),
('21-12-10',2,'',161.43),
('22-04-27',1,'jdjalgbkja-skjdasd',371.76),
('22-04-30',1,'jdjalgbkja-skjdasd',550.39)
;

INSERT INTO actividades_eventos(fecha_fin, tipo_actividad, descripcion, ingreso)
VALUES
('22-01-24',3,'fvf aerg aerh Eh r',1645.88),
('22-04-01',2,'',1698.76),
('22-03-07',3,'fvf aerg aerh Eh r',2168.02),
('22-02-09',2,'',379.45),
('22-03-18',4,'fvf aerg aerh Eh r',1987.85),
('22-07-15',3,'',1733.74),
('22-01-27',3,'',4173.32),
('21-12-17',2,'',36.18),
('22-02-10',2,'fvf aerg aerh Eh r',3958.87),
('21-12-25',4,'fvf aerg aerh Eh r',2818.79),
('22-03-27',2,'fvf aerg aerh Eh r',1463.29),
('21-12-01',3,'fvf aerg aerh Eh r',1070.25),
('22-01-02',1,'fvf aerg aerh Eh r',393.67),
('22-02-14',1,'',4175.44),
('21-11-21',2,'',2929.86)
;

INSERT INTO adoptante
VALUES
(3683040,7,'','22/04/01'),
(3164743,8,'asdf','22/03/07'),
(2776552,3,'','22/02/09'),
(5640447,4,'','22/03/18'),
(7655076,5,'asabf','21/12/25'),
(6020593,6,'','22/03/27'),
(7993893,1,'','21/12/01'),
(9096013,2,'asdfba','22/01/02'),
(2470073,9,'','22/01/27'),
(8955536,10,'','21/12/17')
;




CREATE OR REPLACE VIEW total_ingreso_actividad AS
	SELECT SUM(ingreso) AS ingreso_total
	FROM actividades_eventos
;

CREATE OR REPLACE VIEW total_gasto AS
	SELECT SUM(cantidad_gasto) AS gasto_total
	FROM gastos
;

CREATE OR REPLACE VIEW lista_ingreso_actividad AS
	SELECT COUNT(a.tipo_actividad) AS conteo, ta.tipo AS Actividad, SUM(a.ingreso) AS "Ingreso"
	FROM actividades_eventos AS a
	INNER JOIN tipo_actividad AS ta ON ta.codigo_actividad = a.tipo_actividad
	GROUP BY ta.tipo
;
CREATE OR REPLACE VIEW lista_gasto_tipo AS
	SELECT COUNT(g.id_gastos) AS conteo, tg.tipo AS "Tipo de gasto", SUM(g.cantidad_gasto) AS "Gastos"
    FROM gastos AS g
    INNER JOIN tipo_gasto AS tg ON tg.codigo_gasto = g.tipo
    GROUP BY tg.tipo
;

CREATE OR REPLACE VIEW adoptante_y_mascota AS
SELECT pg.nombres AS Adoptante, m.nombre AS Mascota
	FROM adoptante AS a
	INNER JOIN personas_registro_global AS pg ON pg.dni = a.dni
	INNER JOIN mascota AS m ON m.id_mascota = a.id_mascota
;

    
    
    
    
    
    
    