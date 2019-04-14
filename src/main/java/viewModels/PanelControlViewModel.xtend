package viewModels

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repositorios.RepoLocator

@Observable
@Accessors
class PanelControlViewModel {
	Usuario usuarioLogueado
	Double saldoParaCargar
	Usuario amigoSeleccionado
	Integer edadUsuario

	def setUsuarioLogueado(Usuario usuario) {
		usuarioLogueado = RepoLocator.repoUsuario.searchById(usuario.id)
		edadUsuario = usuarioLogueado.edad
	}

	def nombreApellidoUsuario() {
		return usuarioLogueado.nombre + " " + usuarioLogueado.apellido
	}

	def cargarSaldo() {
		usuarioLogueado.cargarSaldo(saldoParaCargar)
		RepoLocator.repoUsuario.update(usuarioLogueado)
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

	def cambiarEdadUsuario() {
		usuarioLogueado.edad = edadUsuario
		RepoLocator.repoUsuario.update(usuarioLogueado)
	}
}
