package repositorios

import domain.Usuario
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

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

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		Usuario usuario) {
		if (usuario.username !== null) {
			query.where(criteria.equal(camposUsuario.get("username"), usuario.username))
		}
	}

}
