package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Funcion{
	@Id
	@GeneratedValue
	Long id
	
	@JsonIgnore LocalDateTime fechaHora
	String nombreSala

	new(Long _id,LocalDateTime _fechaHora, String _nombreSala, Contenido _contenido) {
		id = _id
		fechaHora = _fechaHora
		nombreSala = _nombreSala
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
