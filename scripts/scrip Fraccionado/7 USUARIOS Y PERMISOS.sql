use mysql;

-- Este usuario es para el personal que cuida las mascotas
CREATE USER 'CuidadorMascota'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Mascota123';

-- Este usuario es para el personal administrativo:
CREATE USER 'AdministradorHuellitas'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Huellitas123';

-- Al personal que cuida mascotas podrá solo leer datos
GRANT SELECT ON nuevo_huellitas.* TO 'CuidadorMascota'@'localhost';
-- El personal administrativo podrá leer, insertar y actualizar datos, mas no eliminar.
GRANT SELECT, INSERT, UPDATE ON nuevo_huellitas.* TO 'AdministradorHuellitas'@'localhost';

-- Eliminando usuarios:
DROP USER 'CuidadorMascota'@'localhost';
DROP USER 'AdministradorHuellitas'@'localhost';
