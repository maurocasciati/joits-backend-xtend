package repositorios

import java.util.List
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.criteria.CriteriaQuery
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.Root
import java.util.function.Function
import javax.persistence.EntityManager
import java.util.ArrayList

@TransactionalAndObservable
abstract class RepoRelacional<T> {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("joits")

	def List<T> allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery as CriteriaQuery<T>
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	abstract def Class<T> getEntityType()

	def searchByExample(T t) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery as CriteriaQuery<T>
			val from = query.from(entityType)
			query.select(from)
			generateWhere(criteria, query, from, t)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	def searchById(Long id, Function<Root<T>, Object> funcion) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery as CriteriaQuery<T>
			val from = query.from(entityType)
			funcion.apply(from)
			query.select(from)
			generateWhereId(criteria, query, from, id)
			val result = entityManager.createQuery(query).resultList

			if (result.isEmpty) {
				null
			} else {
				result.head as T
			}

		} finally {
			entityManager.close
		}
	}

	def searchById(Long id) {
		searchById(id, [fetchNothing])
	}

	def fetchNothing(Root<T> query) {
	}

	abstract def void generateWhere(CriteriaBuilder criteria, CriteriaQuery<T> query, Root<T> camposCandidato, T t)

	abstract def void generateWhereId(CriteriaBuilder criteria, CriteriaQuery<T> query, Root<T> camposCandidato,
		Long id)

	def createDeleteOrUpdate(List<T> objetos, Function<T, Object> funcion, EntityManager entityManager) {
		try {
			entityManager.transaction.begin
			objetos.forEach[objeto|funcion.apply(objeto)]
			entityManager.transaction.commit

		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager.close
		}
	}

	def createAll(List<T> objetos) {
		val entityManager = this.entityManager
		createDeleteOrUpdate(objetos, [object|entityManager.persist(object) return null], entityManager)
	}

	def updateAll(List<T> objetos) {
		val entityManager = this.entityManager
		createDeleteOrUpdate(objetos, [object|entityManager.merge(object)], entityManager)
	}

	def deleteAll(List<T> objetos) {
		val entityManager = this.entityManager
		createDeleteOrUpdate(objetos, [ object |
			var ent = if(entityManager.contains(object)) object else entityManager.merge(object)
			entityManager.remove(ent)
			return null
		], entityManager)
	}

	def create(T t) {
		val entityManager = this.entityManager
		var lista = new ArrayList
		lista.add(t)
		createDeleteOrUpdate(lista, [object|entityManager.persist(object) return null], entityManager)
	}

	def update(T t) {
		val entityManager = this.entityManager
		var lista = new ArrayList
		lista.add(t)
		createDeleteOrUpdate(lista, [object|entityManager.merge(object)], entityManager)
	}

	def delete(T t) {
		val entityManager = this.entityManager
		var lista = new ArrayList
		lista.add(t)
		createDeleteOrUpdate(lista, [ object |
			var ent = if(entityManager.contains(object)) object else entityManager.merge(object)
			entityManager.remove(ent)
			return null
		], entityManager)
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}
}
