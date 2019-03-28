package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Pelicula extends Contenido {
	val Double PRECIO_BASE = 30.0
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
