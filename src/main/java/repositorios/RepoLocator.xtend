package repositorios

import java.util.ArrayList

class RepoLocator {
	def static getRepoContenido() {
		RepoContenido.getInstance
	}

	def static getRepoUsuario() {
		RepoUsuario.getInstance
	}

	def static getRepoEntrada() {
		RepoEntrada.getInstance
	}
	
	def static getRepoFuncion() {
		RepoFuncion.getInstance
	}

}
