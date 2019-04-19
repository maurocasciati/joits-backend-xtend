CREATE VIEW peliculas_mas_vendidas AS
    SELECT 
        titulo, genero, puntaje
    FROM
        contenido
    WHERE
        tipo = 1
            AND id IN (SELECT 
                contenido_id
            FROM
                entrada
            GROUP BY contenido_id
            HAVING COUNT(id) > 3)