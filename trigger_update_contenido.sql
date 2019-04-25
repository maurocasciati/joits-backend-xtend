USE joits;

DROP TABLE IF EXISTS LogPeliculas;

CREATE TABLE LogPeliculas (
    Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Id_Contenido INT NOT NULL,
    Fecha DATETIME NOT NULL,
    TituloViejo VARCHAR(150) NULL,
    TituloNuevo VARCHAR(150) NULL
);

DROP TRIGGER IF EXISTS updatePelicula;

DELIMITER |

CREATE TRIGGER updatePelicula AFTER UPDATE ON Contenido
FOR EACH ROW 
BEGIN
   INSERT INTO LogPeliculas
   (Id_Contenido, Fecha, TituloViejo, TituloNuevo)
   VALUES
   (OLD.id, SYSDATE(), OLD.titulo, NEW.titulo);
END
|

DELIMITER ;

-- PRUEBAS:
UPDATE Contenido
SET titulo = "Die Hard"
WHERE id = 5;

SELECT * FROM LogPeliculas;
