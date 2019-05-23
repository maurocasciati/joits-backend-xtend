package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.io.Serializable
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable

class Saga extends Contenido implements Serializable {

	val Double PRECIO_POR_PELICULA = 10.0

	Integer anioRecopilacion

	Integer nivelClasico

	@JsonIgnore
	List<Pelicula> peliculas

	override getPrecio() {
		return this.precioPorPeliculas + nivelClasico
	}

	def precioPorPeliculas() {
		return peliculas.length * PRECIO_POR_PELICULA
	}

	override getAnio() {
		anioRecopilacion
	}

}
