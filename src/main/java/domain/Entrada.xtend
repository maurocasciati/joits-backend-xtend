package domain

import java.time.LocalDateTime

class Entrada {

	Funcion funcion
	LocalDateTime fechaCompra

	new(Funcion _funcion) {
		funcion = _funcion
	}

	def Double precio() {
		funcion.precio
	}

}
