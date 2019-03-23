package repositorios

import java.util.ArrayList

class RepoLocator {
	def static getRepoContenido() {
		RepoContenido.getInstance
	}

	def static getRepoUsuario() {
		RepoUsuario.getInstance
	}

	def static resetAll() {
		getRepoContenido.pool = new ArrayList
		getRepoUsuario.pool = new ArrayList
	}
}
