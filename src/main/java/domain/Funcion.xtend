package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.Objects
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.mongodb.morphia.annotations.Id
import java.io.Serializable

@Accessors
@Observable

class Funcion implements Serializable{
	
	@Id	Integer id

	LocalDateTime fechaHora
	String nombreSala

	new() {
	}

	new(LocalDateTime _fechaHora, String _nombreSala) {
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
	
	@JsonProperty("id_funcion")
	def String getIdFuncion() {
		id.toString
	}

	def Double getPrecio() {
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

	override equals(Object other) {
		if (other instanceof Funcion) {
			return (other as Funcion).id == id
		}
		false
	}

	override hashCode() {
		Objects.hashCode(id)
	}
}
