package repositorios

import domain.Usuario
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException

class RepoUsuario extends Repositorio<Usuario> {

	static RepoUsuario instance

	private new() {
	}

	def static getInstance() {
		if (instance === null) {
			instance = new RepoUsuario
		}
		instance
	}
	
	override getEntityType() {
		typeof(Usuario)
	}

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("joits")

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	override allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}
	
	override create(Usuario usuario) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(usuario)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager.close
		}
	}
	

}
