package domain

import java.time.LocalDateTime
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.time.format.DateTimeFormatter

@Accessors
@Observable
class Funcion {
	@JsonIgnore LocalDateTime fechaHora
	String nombreSala
	@JsonIgnore Contenido contenido

	new(LocalDateTime _fechaHora, String _nombreSala, Contenido _contenido) {
		fechaHora = _fechaHora
		nombreSala = _nombreSala
		contenido = _contenido
	}

	@JsonProperty("fechaHora")
	def String getFechaYHora() {

		var LocalDateTime now = LocalDateTime.now();
		var DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		var String fecha = formatter.format(fechaHora)

		if (fechaHora === null) {
			formatter.format(now)
		} else {
			fecha
		}
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

	@JsonIgnore
	def getFecha() {
		fechaHora.toLocalDate
	}

	@JsonIgnore
	def getHora() {
		fechaHora.toLocalTime
	}

}
