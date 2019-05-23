package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.io.Serializable

@Accessors
@Observable
class Pelicula extends Contenido implements Serializable {

	val Double PRECIO_BASE = 30.0

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
