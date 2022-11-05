USE huellitas_centro_adopcion;

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