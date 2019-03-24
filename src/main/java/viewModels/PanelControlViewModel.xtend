package viewModels

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorios.RepoLocator

@Observable
@Accessors
class PanelControlViewModel {
	Usuario usuario = RepoLocator.repoUsuario.pool.get(0)
	Integer saldoParaCargar = 0
	Usuario amigoSeleccionado
	
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