package domain

import java.time.LocalDateTime
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class Funcion {
	LocalDateTime fechaHora
	String nombreSala
	Contenido contenido

	new(LocalDateTime _fechaHora, String _nombreSala, Contenido _contenido) {
		fechaHora = _fechaHora
		nombreSala = _nombreSala
		contenido = _contenido
	}

	def Double precio() {
		contenido.precio + precioFecha
	}

	def Double precioFecha() {
		if(esFinDeSemana) 120.0 else if(esMiercoles) 50.0 else 80.0
	}

	def boolean esFinDeSemana() {
		fechaHora.dayOfWeek.value > 5
	}

	def boolean esMiercoles() {
		fechaHora.dayOfWeek.value == 3
	}

	def getFecha() {
		fechaHora.toLocalDate
	}

	def getHora() {
		fechaHora.toLocalTime
	}

}
