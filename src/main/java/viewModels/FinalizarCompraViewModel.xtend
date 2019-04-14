package viewModels

import domain.Entrada
import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repositorios.RepoLocator

@Accessors
@Observable
class FinalizarCompraViewModel {

	Usuario usuarioLogueado
	Entrada itemSeleccionado

	new(Long idLogueado) {
		usuarioLogueado = RepoLocator.repoUsuario.traerUsuarioConCarrito(idLogueado)
	}

	def getCarrito() {
		usuarioLogueado.carrito
	}

	def limpiarCarrito() {
		usuarioLogueado.limpiarCarrito
		RepoLocator.repoUsuario.update(usuarioLogueado)
	}

	def eliminarItem() {
		usuarioLogueado.eliminarItem(itemSeleccionado)
		RepoLocator.repoUsuario.update(usuarioLogueado)
	}

	@Dependencies("carrito")
	def getTotal() {
		"$" + usuarioLogueado.totalCarrito.toString
	}

	@Dependencies("itemSeleccionado")
	def getSeleccionoItem() {
		itemSeleccionado !== null
	}

	@Dependencies("carrito")
	def getCarritoNoVacio() {
		!carrito.isEmpty
	}

	def finalizarCompra() {
		usuarioLogueado.finalizarCompra
		RepoLocator.repoUsuario.update(usuarioLogueado)
	}
}
