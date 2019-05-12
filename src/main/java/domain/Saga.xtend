package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Property
import org.uqbar.commons.model.annotations.Observable
import org.mongodb.morphia.annotations.Embedded

@Accessors
@Observable
@Entity("contenidos")
class Saga extends Contenido {
	
	val Double PRECIO_POR_PELICULA = 10.0
	
	@Property("anioRecopilacion")
	Integer anioRecopilacion
	
	@Property("nivelClasico")
	Integer nivelClasico

	@Embedded
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
