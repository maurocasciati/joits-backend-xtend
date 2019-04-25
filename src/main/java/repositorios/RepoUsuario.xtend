package repositorios

import domain.Usuario
import java.util.HashSet
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import org.uqbar.commons.model.exceptions.UserException

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

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposUsuario.get("id"), id))
		}
	}

	def login(String _username, String password) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposUsuario = query.from(entityType)
			camposUsuario.fetch("carrito", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("username"), _username))
			val result = entityManager.createQuery(query).resultList
			val usuario = result.head as Usuario

			if (result.isEmpty || usuario.getPasswordHash != password) {
				throw new UserException("Credenciales incorrectas")
			}
			usuario

		} finally {
			entityManager.close
		}
	}

	override delete(Usuario usuario) {
		usuario.listaDeAmigos = new HashSet
		super.delete(usuario)
	}

}
