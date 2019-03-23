package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class Saga extends Contenido {
	val Double PRECIO_POR_PELICULA = 10.0
	Integer anioRecopilacion
	List<Pelicula> peliculas
	Integer nivelClasico
	
	override precio() {
		return this.precioPorPeliculas + nivelClasico
	}
	
	def precioPorPeliculas() {
		return peliculas.size * PRECIO_POR_PELICULA
	}
	
}