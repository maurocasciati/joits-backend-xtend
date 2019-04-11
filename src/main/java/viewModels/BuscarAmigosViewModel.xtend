package viewModels

import domain.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repositorios.RepoLocator

@TransactionalAndObservable
@Accessors
class BuscarAmigosViewModel {
	Usuario usuarioLogueado
	Usuario usuarioSeleccionado
	String valorBuscado = ""
	
	def List<Usuario> getListadoUsuarios(){
//		RepoLocator.repoUsuario.pool.filter[usuario|
//			!usuarioLogueado.listaDeAmigos.contains(usuario) &&
//			!usuario.equals(usuarioLogueado)
//		].toList
	}
	
	def List<Usuario> getResultados(){
		getListadoUsuarios.filter[usuario|usuario.coincideEnBusqueda(valorBuscado)].toList
	}
	
	def List<Usuario> getListadoSugeridos(){
		getListadoUsuarios
	}
	
	def agregarAmigo(){
		usuarioLogueado.agregarAmigo(usuarioSeleccionado)
	}
	
}