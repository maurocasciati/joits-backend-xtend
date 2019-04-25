package viewModels

import domain.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repositorios.RepoLocator

@TransactionalAndObservable
@Accessors
class BuscarAmigosViewModel {
	Usuario usuarioLogueado
	Usuario usuarioSeleccionado
	String valorBuscado = ""
	Set<Usuario> todosLosUsuarios

	new() {
		todosLosUsuarios = RepoLocator.repoUsuario.allInstances.toSet
	}

	def getListadoUsuarios() {
		todosLosUsuarios.filter [ usuario |
			!usuarioLogueado.listaDeAmigos.contains(usuario) && !usuario.equals(usuarioLogueado)
		].toSet
	}

	def Set<Usuario> getResultados() {
		getListadoUsuarios.filter[usuario|usuario.coincideEnBusqueda(valorBuscado)].toSet
	}

	def Set<Usuario> getListadoSugeridos() {
		getListadoUsuarios
	}

	def agregarAmigo() {
		usuarioLogueado.agregarAmigo(usuarioSeleccionado)
	}

	def aceptar() {
		RepoLocator.repoUsuario.update(usuarioLogueado)
//		usuarioLogueado = RepoLocator.repoUsuario.searchById(usuarioLogueado.id)		
	}

}
