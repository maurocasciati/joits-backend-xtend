package viewModels

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.annotations.Dependencies

@TransactionalAndObservable
@Accessors
class PanelControlViewModel {
	Usuario usuarioLogueado
	Double saldoParaCargar
	Usuario amigoSeleccionado

	def nombreApellidoUsuario() {
		return usuarioLogueado.nombre + " " + usuarioLogueado.apellido
	}

	def cargarSaldo() {
		usuarioLogueado.cargarSaldo(saldoParaCargar)
	}

	def getSaldoUsuario() {
		usuarioLogueado.saldo
	}

	def getListaDeAmigos() {
		usuarioLogueado.listaDeAmigos
	}

	@Dependencies("saldoParaCargar")
	def getPusoSaldo() {
		saldoParaCargar !== null && saldoParaCargar !== 0
	}
}
