package domain

import java.util.ArrayList
import java.util.List
import java.util.Arrays
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Observable
class Carrito {

	List<Item> items = new ArrayList

	def limpiarCarrito() {
		items = new ArrayList
	}

	def eliminarItem(Item item) {
		items.remove(item)
	}

	def totalCarrito() {
		var double[] precios = items.map[item|item.precio]
		Arrays.stream(precios).sum();
	}

	def agregarAlCarrito(Item entrada) {
		items.add(entrada)
	}
	
	def getEntradas() {
		items.map[ item | new Entrada(item.contenido.titulo) ]
	}

}
