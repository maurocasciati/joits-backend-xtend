package domain

import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Entrada {

	Funcion funcion
	LocalDateTime fechaCompra

	new(Funcion _funcion) {
		funcion = _funcion
	}

	def Double getPrecio() {
		funcion.precio
	}

}
