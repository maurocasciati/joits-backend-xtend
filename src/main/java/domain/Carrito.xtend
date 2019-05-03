package domain

import java.util.ArrayList
import java.util.List
import java.util.Arrays
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class Carrito {

	List<Entrada> entradas = new ArrayList

	def limpiarCarrito() {
		entradas = new ArrayList
	}

	def eliminarItem(Entrada item) {
		entradas.remove(item)
	}

	def totalCarrito() {
		var double[] precios = entradas.map[entrada|entrada.precio]
		Arrays.stream(precios).sum();
	}

	def agregarAlCarrito(Entrada entrada) {
		entradas.add(entrada)
	}

}
