package domain

import java.io.Serializable
import java.util.ArrayList
import java.util.Arrays
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable

class Carrito implements Serializable {

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
