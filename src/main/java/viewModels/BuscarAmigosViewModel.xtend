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
	Set<Usuario> usuariosNoAmigos
	Boolean puedeAceptar = false

	new(Usuario _usuarioLogueado) {
		usuarioLogueado = _usuarioLogueado
		usuariosNoAmigos = RepoLocator.repoUsuario.getNoAmigosDeUsuario(usuarioLogueado.id).toSet
	}

	def getListadoUsuarios() {
		usuariosNoAmigos
	}

	def Set<Usuario> getResultados() {
		getListadoUsuarios.filter[usuario|usuario.coincideEnBusqueda(valorBuscado)].toSet
	}

	def Set<Usuario> getListadoSugeridos() {
		getListadoUsuarios
	}

	def agregarAmigo() {
		usuarioLogueado.agregarAmigo(usuarioSeleccionado)
		usuariosNoAmigos.remove(usuarioSeleccionado)
		puedeAceptar = true
	}

	def aceptar() {
		RepoLocator.repoUsuarioNeo.guardarUsuario(usuarioLogueado)
		RepoLocator.repoUsuario.update(usuarioLogueado)
//		usuarioLogueado = RepoLocator.repoUsuario.searchById(usuarioLogueado.id)		
	}

}
