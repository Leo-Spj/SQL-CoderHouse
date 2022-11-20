-- funciones

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