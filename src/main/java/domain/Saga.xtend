package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.Column
import javax.persistence.DiscriminatorValue

@Accessors
@Observable
@Entity
@DiscriminatorValue("2")
class Saga extends Contenido {
	@Column
	val Double PRECIO_POR_PELICULA = 10.0
	@Column
	Integer anioRecopilacion
	transient List<Pelicula> peliculas
	@Column
	Integer nivelClasico

	override precio() {
		return this.precioPorPeliculas + nivelClasico
	}

	def precioPorPeliculas() {
		return peliculas.size * PRECIO_POR_PELICULA
	}

	override getAnio() {
		anioRecopilacion
	}

}
