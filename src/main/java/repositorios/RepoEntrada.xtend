package repositorios

import domain.Entrada

class RepoEntrada extends Repositorio<Entrada> {

	static RepoEntrada instance

	private new() {
	}


	protected def void updateFieldByField(Entrada encontrado, Entrada nuevoDato) {
//		encontrado.titulo = nuevoDato.titulo
//		encontrado.puntaje = nuevoDato.puntaje
//		encontrado.genero = nuevoDato.genero
//		encontrado.funciones = nuevoDato.funciones
	}

	def static getInstance() {
		if (instance === null) {
			instance = new RepoEntrada
		}
		instance
	}
	
	override getEntityType() {
		typeof(Entrada)
	}

}
