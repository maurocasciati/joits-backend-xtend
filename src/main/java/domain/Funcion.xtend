package domain

import java.time.LocalDateTime
import java.math.BigDecimal

class Funcion {
	LocalDateTime fechaHora
	String nombreSala
	Contenido contenido
	
	def BigDecimal precio(){
		return this.contenido.precio() + this.precioFecha()
	}
	
	def BigDecimal precioFecha() {
		return new BigDecimal(20)
	}
	
}