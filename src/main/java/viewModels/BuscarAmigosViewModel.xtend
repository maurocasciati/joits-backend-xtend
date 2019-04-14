package viewModels

import domain.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repositorios.RepoLocator
import java.util.Set

@TransactionalAndObservable
@Accessors
class BuscarAmigosViewModel {
	Usuario usuarioLogueado
	Usuario usuarioSeleccionado
	String valorBuscado = ""

	def Set<Usuario> getListadoUsuarios() {
		RepoLocator.repoUsuario.allInstances.filter [ usuario |
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
//		usuarioSeleccionado.agregarAmigo(usuarioLogueado)
		RepoLocator.repoUsuario.update(usuarioLogueado)
//		RepoLocator.repoUsuario.update(usuarioSeleccionado)

	}

}
