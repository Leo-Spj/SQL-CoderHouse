-- triggers
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