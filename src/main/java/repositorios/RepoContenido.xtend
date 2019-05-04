package repositorios

import domain.Contenido
import java.util.ArrayList
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import domain.Funcion

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

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Contenido> query, Root<Contenido> camposContenido,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposContenido.get("id"), id))
		}
	}

	def generateWhereIdFuncion(CriteriaBuilder criteria, CriteriaQuery<Funcion> query, Root<Funcion> camposFuncion,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposFuncion.get("id"), id))
		}
	}

	def getContenidoConFunciones(Long id) {
		searchById(id, [fetchContenidoConFunciones])
	}

	def getFuncionById(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Funcion)
			val from = query.from(Funcion)
			query.select(from)
			generateWhereIdFuncion(criteria, query, from, id)
			val result = entityManager.createQuery(query).resultList

			if (result.isEmpty) {
				null
			} else {
				result.head as Funcion
			}

		} finally {
			entityManager.close
		}
	}

	def fetchContenidoConFunciones(Root<Contenido> query) {
		query.fetch("funciones", JoinType.LEFT)
	}

	override delete(Contenido contenido) {
		contenido.funciones = new ArrayList
		super.delete(contenido)
	}

}
