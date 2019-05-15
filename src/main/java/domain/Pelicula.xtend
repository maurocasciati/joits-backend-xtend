package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Property
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Pelicula extends Contenido {

	val Double PRECIO_BASE = 30.0

	@Property("anioRodaje")
	Integer anioRodaje

	new() {
	}

	new(String _titulo, Double _puntaje, String _genero, Integer _anioRodaje, String _apiID) {
		titulo = _titulo
		puntaje = _puntaje
		genero = _genero
		anioRodaje = _anioRodaje
		apiID = _apiID
	}

	override getPrecio() {
		return PRECIO_BASE
	}

	override getAnio() {
		anioRodaje
	}

}
