package repositorios

import domain.Contenido
import java.util.ArrayList
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
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

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Contenido> query, Root<Contenido> camposContenido,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposContenido.get("id"), id))
		}
	}

	def getContenidoConFunciones(Long id) {
		searchById(id, [fetchContenidoConFunciones])
	}

	def fetchContenidoConFunciones(Root<Contenido> query) {
		query.fetch("funciones", JoinType.LEFT)
	}

	override delete(Contenido contenido) {
		contenido.funciones = new ArrayList
		super.delete(contenido)
	}

}
