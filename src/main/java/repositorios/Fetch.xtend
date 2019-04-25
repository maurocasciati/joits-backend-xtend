package repositorios

import domain.Contenido
import domain.Usuario
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

interface Fetch<T> {
	def void doFetch(Root<T> query)
}

class FetchNothing<T> implements Fetch<T> {
	override doFetch(Root<T> query) {
	}
}

class FetchUsuarioConCarritoCompleto implements Fetch<Usuario> {

	override doFetch(Root<Usuario> query) {
		val camposCarrito = query.fetch("carrito", JoinType.LEFT)
		val camposContenido = camposCarrito.fetch("contenido", JoinType.LEFT)
//		camposContenido.fetch("peliculas", JoinType.LEFT)
		camposCarrito.fetch("funcion", JoinType.LEFT)
		query.fetch("entradas", JoinType.LEFT)
	}
}

class FetchUsuarioConEntradas implements Fetch<Usuario> {

	override doFetch(Root<Usuario> query) {
		val camposEntrada = query.fetch("entradas", JoinType.LEFT)
		camposEntrada.fetch("contenido", JoinType.LEFT)
//		camposEntrada.fetch("funcion", JoinType.LEFT)

	}
}

class FetchUsuarioConCarrito implements Fetch<Usuario> {

	override doFetch(Root<Usuario> query) {
		query.fetch("carrito", JoinType.LEFT)
	}
}

class FetchUsuarioConAmigosYEntradas implements Fetch<Usuario> {

	override doFetch(Root<Usuario> query) {
		val camposAmigos = query.fetch("listaDeAmigos", JoinType.LEFT)
		val camposEntradas = camposAmigos.fetch("entradas", JoinType.LEFT)
		camposEntradas.fetch("contenido", JoinType.LEFT)
	}
}

class FetchUsuarioConAmigos implements Fetch<Usuario> {

	override doFetch(Root<Usuario> query) {
		query.fetch("listaDeAmigos", JoinType.LEFT)
	}
}

class FetchContenidoConFunciones implements Fetch<Contenido> {

	override doFetch(Root<Contenido> query) {
		query.fetch("funciones", JoinType.LEFT)
	}
}
