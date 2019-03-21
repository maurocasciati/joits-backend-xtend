package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Pelicula {
	String titulo
	Integer anioRodaje
	Float puntaje
	String genero //accion, comedia, drama, ciencia ficcion	
	List<Funcion> funciones
}