package repositorios

import domain.Usuario
import java.util.HashSet
import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import org.uqbar.commons.model.exceptions.UserException
import java.util.ArrayList
import javax.persistence.NoResultException

class RepoUsuario extends RepoRelacional<Usuario> {

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

	def List<Usuario> getNoAmigosDeUsuario(Long id) {
		val entityManager = this.entityManager
		try {
			var query = entityManager.createQuery(
				"SELECT NEW Usuario(user.id, user.nombre, user.apellido) FROM Usuario user where user.id not in (SELECT amigos.id FROM Usuario user join user.listaDeAmigos as amigos on user.id = usuario_id) and user.id != :id_logueado",
				Usuario).setParameter("id_logueado", id)
			val List<Usuario> usuarios = query.resultList
			usuarios

		} finally {
			entityManager.close
		}
	}

	def getUsuarioConEntradas(Long id) {
		searchById(id, [fetchUsuarioConEntradas])
	}

	def fetchUsuarioConEntradas(Root<Usuario> query) {
		query.fetch("entradas", JoinType.LEFT)
//		camposEntrada.fetch("funcion", JoinType.LEFT)
	}

	def getUsuarioConAmigosYEntradas(Long id) {
		searchById(id, [FetchUsuarioConAmigosYEntradas])
	}

	def FetchUsuarioConAmigosYEntradas(Root<Usuario> query) {
		val camposAmigos = query.fetch("listaDeAmigos", JoinType.LEFT)
		camposAmigos.fetch("entradas", JoinType.LEFT)
	}

	def getUsuarioConAmigos(Long id) {
		searchById(id, [FetchUsuarioConAmigos])

	}

	def FetchUsuarioConAmigos(Root<Usuario> query) {
		query.fetch("listaDeAmigos", JoinType.LEFT)
	}

	def login(String _username, String password) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposUsuario = query.from(entityType)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("username"), _username))
			val usuario = entityManager.createQuery(query).singleResult as Usuario
			if (usuario.getPasswordHash != password) {
				throw new UserException("Credenciales incorrectas")
			}
			usuario

		} catch (NoResultException e) {
			throw new UserException("Credenciales incorrectas")

		} finally {
			entityManager.close
		}
	}

	override delete(Usuario usuario) {
		usuario.entradas = new ArrayList
		usuario.listaDeAmigos = new HashSet
		super.delete(usuario)
	}

}
