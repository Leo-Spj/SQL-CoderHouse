-- triggers
DELIMITER $$
CREATE TRIGGER `trg_eliminar-mascotaPersonal`
AFTER DELETE ON mascota_personal 
FOR EACH ROW
BEGIN
	INSERT INTO trg_cuidadores_historial(id_mascota, codigo_personal, fecha_asignada, fecha_adoptado)
    VALUES (OLD.id_mascota, OLD.codigo_personal, OLD.fecha_asignada, CURDATE());
END$$
DELIMITER ;