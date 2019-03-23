package domain

import java.time.LocalDateTime

class Funcion {
	LocalDateTime fechaHora
	String nombreSala

	new() {
	}

	new(LocalDateTime _fechaHora, String _nombreSala) {
		fechaHora = _fechaHora
		nombreSala = _nombreSala
	}

	def Double precio() {
		if(esFinDeSemana) 120.0 else if(esMiercoles) 50.0 else 80.0
	}

	def boolean esFinDeSemana() {
		fechaHora.dayOfWeek.value > 5
	}

	def boolean esMiercoles() {
		fechaHora.dayOfWeek.value == 3
	}
}
