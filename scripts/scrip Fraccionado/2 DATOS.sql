-- datos
USE nuevo_huellitas;

INSERT INTO especies(especie)
VALUES
 ('perro'),
 ('gato')
;
INSERT INTO tamaño(tamaño)
VALUES
 ('pequeño'),
 ('mediano'),
 ('grande')
;
INSERT INTO sexo
VALUES
 (1,'macho'),
 (2,'hembra')
;
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
INSERT INTO mascota_personal
VALUES
(7,4,'2020-11-17'),
(1,5,'2020-12-02'),
(4,6,'2021-02-06'),
(12,7,'2021-02-06')
;
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
-- la mascota con codigo 15 la dejaré sin cuidado del personal
-- (15,88250405,'2022-11-11'),
(14,72919941,'2022-11-23')
;
INSERT INTO observaciones_adoptante
VALUES
(7,'2022-11-03','La mascota fue dejada sin alimento tras irse de viaje un dia. La mascota está bien. Le hicimos una llamada de atencion.')
;
