package viewModels

import domain.Carrito
import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repositorios.RepoLocator
import domain.Item

@Accessors
@Observable
class FinalizarCompraViewModel {

	Usuario usuarioLogueado
	Item itemSeleccionado
	Carrito carrito

	new(Long idLogueado, Carrito _carrito) {
		usuarioLogueado = RepoLocator.repoUsuario.getUsuarioConEntradas(idLogueado)
		carrito = _carrito
	}

	def getCarrito() {
		carrito.getItems
	}

	def limpiarCarrito() {
		carrito.limpiarCarrito
	}

	def eliminarItem() {
		carrito.eliminarItem(itemSeleccionado)
	}

	@Dependencies("carrito")
	def getTotal() {
		"$" + carrito.totalCarrito.toString
	}

	@Dependencies("itemSeleccionado")
	def getSeleccionoItem() {
		itemSeleccionado !== null
	}

	@Dependencies("carrito")
	def getCarritoNoVacio() {
		!carrito.getItems.isEmpty
	}

	def finalizarCompra() {
		usuarioLogueado.finalizarCompra(carrito)
		RepoLocator.repoUsuario.update(usuarioLogueado)
	}
}
