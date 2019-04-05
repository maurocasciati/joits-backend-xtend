package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorios.Entidad

@Accessors
@Observable
class Entrada extends Entidad {

	Contenido contenido
	Funcion funcion
	LocalDateTime fechaCompra

	new(Contenido _contenido, Funcion _funcion) {
		contenido = _contenido
		funcion = _funcion
	}

	new() {
	}

	def Double getPrecio() {
		contenido.precio + funcion.precio
	}

	def asignarFechaCompra() {
		fechaCompra = LocalDateTime.now
	}

	@JsonIgnore
	def getPrecioString() {
		"$" + precio.toString
	}

}
