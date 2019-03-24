package viewModels

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class PanelControlViewModel {
	Usuario usuario
	Integer saldoParaCargar
	
	def nombreApellidoUsuario(){
		return usuario.nombre + " " + usuario.apellido
	}
	
	def buscarAmigos() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def cargarSaldo() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}