package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.io.Serializable
import java.util.Objects
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable

class Item implements Serializable {
	Long id

	Contenido contenido
	
	Funcion funcion

	new(Contenido _contenido, Funcion _funcion) {
		contenido = _contenido
		funcion = _funcion
	}

	new() {
	}

	def Double getPrecio() {
		contenido.precio + funcion.precio
	}

	@JsonIgnore
	def getPrecioString() {
		"$" + precio.toString
	}

	override equals(Object other) {
		if (other instanceof Item) {
			return (other as Item).id == id
		}
		false
	}

	override hashCode() {
		Objects.hashCode(id)
	}
}
