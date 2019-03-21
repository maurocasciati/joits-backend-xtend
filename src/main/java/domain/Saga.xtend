package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Saga {
	String titulo
	Integer anioRecopilacion
	Float puntaje
	String genero //accion, comedia, drama, ciencia ficcion
	List<Funcion> funciones	
}