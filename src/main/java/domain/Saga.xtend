package domain

import javax.persistence.Column
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.OneToMany
import javax.persistence.JoinColumn
import java.util.List

@Accessors
@Observable
@Entity
@DiscriminatorValue("2")
class Saga extends Contenido {
	@Column
	val Double PRECIO_POR_PELICULA = 10.0
	@Column
	Integer anioRecopilacion

	@Column
	Integer nivelClasico

	@Column
	Integer cantidadDePeliculas
	
	@OneToMany()
	@JoinColumn(name="id_saga")
	List<Pelicula> peliculas

	override precio() {
		return this.precioPorPeliculas + nivelClasico
	}

	def precioPorPeliculas() {
		return cantidadDePeliculas * PRECIO_POR_PELICULA
	}

	override getAnio() {
		anioRecopilacion
	}

}
