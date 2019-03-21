package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Saga implements Contenido {
	val Double PRECIO_POR_PELICULA = 10.0
	String titulo
	Integer anioRecopilacion
	Float puntaje
	String genero //accion, comedia, drama, ciencia ficcion
	List<Funcion> funciones
	List<Pelicula> peliculas
	Integer nivelClasico
	
	override precio() {
		return this.precioPorPeliculas + nivelClasico
	}
	
	def precioPorPeliculas() {
		return peliculas.size * PRECIO_POR_PELICULA
	}
	
}