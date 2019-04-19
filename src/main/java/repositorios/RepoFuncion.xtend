package repositorios

import domain.Funcion
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepoFuncion extends Repositorio<Funcion> {
	static RepoFuncion instance

	private new() {
	}

	def static getInstance() {
		if (instance === null) {
			instance = new RepoFuncion
		}
		instance
	}

	override getEntityType() {
		typeof(Funcion)
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Funcion> query, Root<Funcion> camposFuncion,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposFuncion.get("id"), id))
		}
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Funcion> query, Root<Funcion> camposFuncion,
		Funcion funcion) {
		if (funcion.nombreSala !== null) {
			query.where(criteria.equal(camposFuncion.get("nombreSala"), funcion.nombreSala))
		}
	}
}
