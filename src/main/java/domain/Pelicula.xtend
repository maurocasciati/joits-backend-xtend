package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Pelicula implements Contenido{
	val Double PRECIO_BASE = 30.0
	String titulo
	Integer anioRodaje
	Float puntaje
	String genero //accion, comedia, drama, ciencia ficcion	
	List<Funcion> funciones
	
	override precio() {
		return PRECIO_BASE
	}
	
	
}