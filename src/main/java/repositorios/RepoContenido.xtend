package repositorios

import domain.Contenido
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

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

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Contenido> query, Root<Contenido> camposContenido,
		Contenido contenido) {
		if (contenido.titulo !== null) {
			query.where(criteria.equal(camposContenido.get("titulo"), contenido.titulo))
		}
	}

	def Contenido searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposContenido = query.from(entityType)
			camposContenido.fetch("funciones")
			query.select(camposContenido)
			query.where(criteria.equal(camposContenido.get("id"), id))
			val result = entityManager.createQuery(query).resultList

			if (result.isEmpty) {
				null
			} else {
				result.head as Contenido
			}
			
		} finally {
			entityManager.close
		}
	}

}
