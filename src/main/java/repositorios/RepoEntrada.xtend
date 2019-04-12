package repositorios

import domain.Entrada
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

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

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Entrada> query, Root<Entrada> camposEntrada,
		Entrada entrada) {
//		if (entrada.contenido.titulo !== null) {
//			query.where(criteria.equal(camposEntrada.get("descripcion"), zona.descripcion))
//		}
	}

}
