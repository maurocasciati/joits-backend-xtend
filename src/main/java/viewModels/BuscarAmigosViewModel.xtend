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
	Usuario usuarioSeleccionado
	String valorBuscado = ""
	List<Usuario> listadoUsuarios = RepoLocator.repoUsuario.pool
	
	def void resetLista(){
		listadoUsuarios = new ArrayList()
		listadoUsuarios = RepoLocator.repoUsuario.pool
	}

	def buscarAmigos() {
		resetLista
		listadoUsuarios = RepoLocator.repoUsuario.busqueda(valorBuscado)
	}
	
	def List<Usuario> getResultados(){
		listadoUsuarios.filter[usuario|usuario.coincideEnBusqueda(valorBuscado)].toList
	}
	
	def List<Usuario> getListadoSugeridos(){
		listadoUsuarios
	}
	

}