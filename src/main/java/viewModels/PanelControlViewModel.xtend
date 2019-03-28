package viewModels

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
@Accessors
class PanelControlViewModel {
	Usuario usuarioLogueado
	Double saldoParaCargar = 0.0
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
	
	def getListaDeAmigos(){
		usuarioLogueado.listaDeAmigos
	}
}
