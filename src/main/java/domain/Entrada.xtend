package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorios.Entidad

@Accessors
@Observable
class Entrada extends Entidad {

	Funcion funcion
	LocalDateTime fechaCompra

	new(Funcion _funcion) {
		funcion = _funcion
	}

	def Double getPrecio() {
		funcion.precio
	}

	def asignarFechaCompra() {
		fechaCompra = LocalDateTime.now
	}

	@JsonIgnore
	def getPrecioString() {
		"$" + precio.toString
	}

}
