package viewModels

import domain.Entrada
import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class FinalizarCompraViewModel {

	Usuario usuarioLogueado
	Entrada itemSeleccionado

	def getCarrito() {
		usuarioLogueado.carrito
	}

	def limpiarCarrito() {
		usuarioLogueado.limpiarCarrito
	}

	def eliminarItem() {
		usuarioLogueado.eliminarItem(itemSeleccionado)
	}

	@Dependencies("carrito")
	def getTotal() {
		usuarioLogueado.totalCarrito
	}
	
	@Dependencies("itemSeleccionado")
	def getSeleccionoItem() {
		itemSeleccionado !== null
	}
	
	@Dependencies("carrito")
	def getCarritoNoVacio() {
		!carrito.isEmpty
	}
	
	@Dependencies("carrito")
	def finalizarCompra() {
		usuarioLogueado.finalizarCompra
	}
}
