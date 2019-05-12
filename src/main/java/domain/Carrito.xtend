package domain

import java.util.ArrayList
import java.util.List
import java.util.Arrays
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class Carrito {

	List<Item> entradas = new ArrayList

	def limpiarCarrito() {
		entradas = new ArrayList
	}

	def eliminarItem(Item item) {
		entradas.remove(item)
	}

	def totalCarrito() {
		var double[] precios = entradas.map[entrada|entrada.precio]
		Arrays.stream(precios).sum();
	}

	def agregarAlCarrito(Item entrada) {
		entradas.add(entrada)
	}

}
