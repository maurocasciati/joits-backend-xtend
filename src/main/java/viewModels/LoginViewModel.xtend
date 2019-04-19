package viewModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorios.RepoLocator
import repositorios.RepoUsuario
import vistas.Login
import org.uqbar.commons.model.annotations.Dependencies
import domain.Usuario

@Accessors
@Observable
class LoginViewModel {

	String username
	String password
	RepoUsuario repoUsuario

	new() {
		repoUsuario = RepoLocator.repoUsuario
	}

	def aceptar(Login pantallaLogin) {
		val Usuario usuario = repoUsuario.login(username,password)
		pantallaLogin.accept
		pantallaLogin.irASeleccionarPelicula(usuario)
	}

	@Dependencies("username", "password")
	def getCompletoCampos() {
		!username.nullOrEmpty && !password.nullOrEmpty
	}
}
