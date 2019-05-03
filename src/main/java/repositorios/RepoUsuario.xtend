package repositorios

import domain.Usuario
import java.util.HashSet
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import org.uqbar.commons.model.exceptions.UserException
import java.util.function.Function

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

	def getUsuarioConCarritoCompleto(Long id) {
		searchById(id, [fetchUsuarioConCarritoCompleto])
	}

	def fetchUsuarioConCarritoCompleto(Root<Usuario> query) {
		val camposCarrito = query.fetch("carrito", JoinType.LEFT)
		val camposContenido = camposCarrito.fetch("contenido", JoinType.LEFT)
//		camposContenido.fetch("peliculas", JoinType.LEFT)
		camposCarrito.fetch("funcion", JoinType.LEFT)
		query.fetch("entradas", JoinType.LEFT)
	}

	def getUsuarioConCarrito(Long id) {
		searchById(id, [fetchUsuarioConCarrito])
	}

	def fetchUsuarioConCarrito(Root<Usuario> query) {
		query.fetch("carrito", JoinType.LEFT)
	}

	def getUsuarioConEntradas(Long id) {
		searchById(id, [fetchUsuarioConEntradas])
	}

	def fetchUsuarioConEntradas(Root<Usuario> query) {
		val camposEntrada = query.fetch("entradas", JoinType.LEFT)
		camposEntrada.fetch("contenido", JoinType.LEFT)
//		camposEntrada.fetch("funcion", JoinType.LEFT)
	}

	def getUsuarioConAmigosYEntradas(Long id) {
		searchById(id, [FetchUsuarioConAmigosYEntradas])
	}

	def FetchUsuarioConAmigosYEntradas(Root<Usuario> query) {
		val camposAmigos = query.fetch("listaDeAmigos", JoinType.LEFT)
		val camposEntradas = camposAmigos.fetch("entradas", JoinType.LEFT)
		camposEntradas.fetch("contenido", JoinType.LEFT)
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
			camposUsuario.fetch("carrito", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("username"), _username))
			val usuario = entityManager.createQuery(query).singleResult as Usuario
			if (usuario.getPasswordHash != password) {
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
