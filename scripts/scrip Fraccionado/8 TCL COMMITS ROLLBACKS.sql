-- TCL - Transaction Control Language
use nuevo_huellitas;

START TRANSACTION;

INSERT INTO mascota(fecha_ingreso, nombre, edad, codigo_especie, codigo_tamaño, codigo_sexo)
VALUES
('2022-12-03','Fido','2020-12-00',1,2,1),
('2022-12-03','Firulais','2020-12-00',1,2,1);
SAVEPOINT primer_elemento;

INSERT INTO mascota(fecha_ingreso, nombre, edad, codigo_especie, codigo_tamaño, codigo_sexo)
VALUES
('2022-12-03','Flofi','2019-12-00',1,1,1);

SELECT * FROM nuevo_huellitas.mascota;

ROLLBACK TO primer_elemento;
COMMIT;




START TRANSACTION;

INSERT INTO telefonos
VALUES
(10000000,'444-654'),
(77827980,'9101234487'),
(80772770,'1567810651'),
(68191408,'1868645671');
SAVEPOINT cuatro_telefonos;

INSERT INTO telefonos
VALUES
(72506704,'96654390549'),
(72919941,'4608885544'),
(83315590,'4478832985'),
(60831369,'9009225283');

ROLLBACK TO cuatro_telefonos;
COMMIT;





