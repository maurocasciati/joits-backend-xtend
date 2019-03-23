package repositorios

import domain.Contenido

class RepoContenido extends Repositorio<Contenido> {

	static RepoContenido instance

	private new() {
	}

	override create(Contenido object) {
//		object.validar // -> si tiene errores de validación, no puede sumar objecto al repo.
		super.create(object)
	}

	override updateRecord(Contenido object) {
		var objetoEncontrado = searchById(object.id)
//		object.validar
		updateFieldByField(objetoEncontrado, object)
	}

	protected def void updateFieldByField(Contenido encontrado, Contenido nuevoDato) {
		encontrado.titulo = nuevoDato.titulo
		encontrado.puntaje = nuevoDato.puntaje
		encontrado.genero = nuevoDato.genero
		encontrado.funciones = nuevoDato.funciones
	}

	def static getInstance() {
		if (instance === null) {
			instance = new RepoContenido
		}
		instance
	}

}
