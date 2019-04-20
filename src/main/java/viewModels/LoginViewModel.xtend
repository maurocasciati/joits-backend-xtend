package viewModels

import domain.Usuario
import org.apache.commons.codec.digest.DigestUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repositorios.RepoLocator
import repositorios.RepoUsuario
import vistas.Login

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
		val String hashString = DigestUtils.sha256Hex(password) 
		val Usuario usuario = repoUsuario.login(username, hashString.toUpperCase())
		pantallaLogin.accept
		pantallaLogin.irASeleccionarPelicula(usuario)
	}

	@Dependencies("username", "password")
	def getCompletoCampos() {
		!username.nullOrEmpty && !password.nullOrEmpty
	}
}
