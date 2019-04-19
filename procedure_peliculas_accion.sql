DELIMITER //
CREATE PROCEDURE PeliculasDeAccionPorSala(IN parametro VARCHAR(100))
BEGIN
	SELECT titulo, anioRodaje, puntaje
	FROM contenido
	WHERE tipo = 1 
	AND genero = "Acción"
	AND id IN (SELECT id_contenido FROM funcion WHERE UPPER(nombreSala) LIKE (CONCAT('%',parametro,'%')));
END //
DELIMITER ;