package repositorios

import domain.Usuario
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import org.uqbar.commons.model.exceptions.UserException
import javax.persistence.criteria.JoinType
import java.util.HashSet
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

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		Usuario usuario) {
		if (usuario.username !== null) {
			query.where(criteria.equal(camposUsuario.get("username"), usuario.username))
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
			if (result.isEmpty) {
				null
			} else {
				if (usuario.contrasenia != password) {
					throw new UserException("Credenciales incorrectas")
				}
				usuario
			}

		} finally {
			entityManager.close
		}
	}

	def Usuario searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposUsuario = query.from(entityType)
			val camposAmigos = camposUsuario.fetch("listaDeAmigos", JoinType.LEFT)
			val camposEntradas = camposAmigos.fetch("entradas", JoinType.LEFT)
			camposEntradas.fetch("contenido", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), id))
			val result = entityManager.createQuery(query).resultList

			if (result.isEmpty) {
				null
			} else {
				result.head as Usuario
			}

		} finally {
			entityManager.close
		}
	}

	def Usuario traerUsuarioConCarrito(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposUsuario = query.from(entityType)
			val camposCarrito = camposUsuario.fetch("carrito", JoinType.LEFT)
			camposCarrito.fetch("contenido", JoinType.LEFT)
			camposCarrito.fetch("funcion", JoinType.LEFT)
			camposUsuario.fetch("entradas", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), id))
			val result = entityManager.createQuery(query).resultList
			if (result.isEmpty) {
				null
			} else {
				result.head as Usuario
			}

		} finally {
			entityManager.close
		}
	}

	def traerUsuarioLogueado(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposUsuario = query.from(entityType)
			camposUsuario.fetch("carrito", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), id))
			val result = entityManager.createQuery(query).resultList
			if (result.isEmpty) {
				null
			} else {
				result.head as Usuario
			}

		} finally {
			entityManager.close
		}
	}

	override delete(Usuario usuario) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				usuario.listaDeAmigos = new HashSet
				val Usuario usuarioNuevo = merge(usuario)
				remove(usuarioNuevo)
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
