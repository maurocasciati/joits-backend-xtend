package repositorios

import domain.Entrada

class RepoEntrada extends Repositorio<Entrada> {

	static RepoEntrada instance

	private new() {
	}

	override create(Entrada object) {
//		object.validar // -> si tiene errores de validación, no puede sumar objecto al repo.
		super.create(object)
	}

	override updateRecord(Entrada object) {
		var objetoEncontrado = searchById(object.id)
//		object.validar
		updateFieldByField(objetoEncontrado, object)
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

}
