package viewModels

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class PanelControlViewModel {
	Usuario usuarioLogueado
	Double saldoParaCargar
	Usuario amigoSeleccionado
	Integer edadUsuario 
	
	def setUsuarioLogueado(Usuario usuario){
		usuarioLogueado = usuario
		edadUsuario = usuario.edad
	}
	
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
	
	def cambiarEdadUsuario() {
		usuarioLogueado.edad = edadUsuario
	}
}
