package domain

import java.time.LocalDateTime

class Entrada {

	Contenido contenido
	Funcion funcion
	LocalDateTime fechaCompra

	def Double precio() {
		contenido.precio + funcion.precio
	}
	
	

}
