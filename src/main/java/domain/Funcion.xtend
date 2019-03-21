package domain

import java.time.LocalDateTime

class Funcion {
	LocalDateTime fechaHora
	String nombreSala
	Contenido contenido
	
	def Double precio(){
		return this.contenido.precio() + this.precioFecha()
	}
	
	def Double precioFecha() {
		return 20.0
	}
	
}