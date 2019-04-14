package domain

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.Column
import javax.persistence.DiscriminatorValue

@Accessors
@Entity
@Observable
@DiscriminatorValue("1")
class Pelicula extends Contenido {

	@Column
	val Double PRECIO_BASE = 30.0
	@Column
	Integer anioRodaje

	new() {
	}

	new(String _titulo, Double _puntaje, String _genero, Integer _anioRodaje) {
		titulo = _titulo
		puntaje = _puntaje
		genero = _genero
		anioRodaje = _anioRodaje
	}

	override precio() {
		return PRECIO_BASE
	}

	override getAnio() {
		anioRodaje
	}
	
}
