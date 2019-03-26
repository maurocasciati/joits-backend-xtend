package viewModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import domain.Usuario
import java.util.List
import repositorios.RepoLocator
import java.util.ArrayList

@TransactionalAndObservable
@Accessors
class BuscarAmigosViewModel {
	Usuario usuarioLogueado
	Usuario amigoSeleccionado
	String valorBuscado = ""
	List<Usuario> listado = RepoLocator.repoUsuario.pool
	
	def void resetLista(){
		listado = new ArrayList()
		listado = RepoLocator.repoUsuario.pool
	}

	def buscarAmigos() {
		resetLista
		listado = RepoLocator.repoUsuario.busqueda(valorBuscado)
	}
	

}