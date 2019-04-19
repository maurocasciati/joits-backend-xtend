package viewModels

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repositorios.RepoLocator
import repositorios.FetchUsuarioConAmigos

@Observable
@Accessors
class PanelControlViewModel {
	Usuario usuarioLogueado
	Double saldoParaCargar
	Usuario amigoSeleccionado
	Integer edadUsuario

	new(Long idLogueado) {
		usuarioLogueado = RepoLocator.repoUsuario.searchById(idLogueado, new FetchUsuarioConAmigos)
		edadUsuario = usuarioLogueado.edad
	}

	def nombreApellidoUsuario() {
		return usuarioLogueado.nombre + " " + usuarioLogueado.apellido
	}

	def cargarSaldo() {
		usuarioLogueado.cargarSaldo(saldoParaCargar)
		RepoLocator.repoUsuario.update(usuarioLogueado)
//		traerUsuarioLogueado
	}

	def getSaldoUsuario() {
		"$" + usuarioLogueado.saldo.toString
	}

	def getListaDeAmigos() {
		usuarioLogueado.listaDeAmigos
	}

	@Dependencies("saldoParaCargar")
	def getPusoSaldo() {
		saldoParaCargar !== null && saldoParaCargar !== 0
	}

	def actualizar() {
		usuarioLogueado.edad = edadUsuario
		RepoLocator.repoUsuario.update(usuarioLogueado)
	}

	def traerUsuarioLogueado() {
		usuarioLogueado = RepoLocator.repoUsuario.searchById(usuarioLogueado.id, new FetchUsuarioConAmigos)
	}

}
