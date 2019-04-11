package repositorios

import domain.Contenido

class RepoContenido extends Repositorio<Contenido> {

	static RepoContenido instance

	private new() {
	}

	def static getInstance() {
		if (instance === null) {
			instance = new RepoContenido
		}
		instance
	}
	
	override getEntityType() {
		typeof(Contenido)
	}

}
