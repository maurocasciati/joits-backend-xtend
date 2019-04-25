DELIMITER //
CREATE PROCEDURE PeliculasDeAccionPorSala(IN parametro VARCHAR(100))
BEGIN
	SELECT titulo, anioRodaje, puntaje
	FROM Contenido
	WHERE tipo = 1 
	AND genero = "Acción"
	AND id IN (SELECT id_contenido FROM Funcion WHERE UPPER(nombreSala) LIKE (CONCAT('%',parametro,'%')));
END //
DELIMITER ;
