package application

import com.fasterxml.jackson.databind.ObjectMapper
import domain.Entrada
import domain.Usuario
import java.util.Set
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import repositorios.RepoLocator

@Controller
class UsuariosApiRest {

	extension JSONUtils = new JSONUtils

	@Get("/usuarios/:nombre")
	def getBuscarUsuariosPorNombre() {
		var Usuario proto = new Usuario()
		proto.nombre = nombre
		return ok(RepoLocator.repoUsuario.searchByExample(proto).toJson)
	}

	@Get("/usuarios/id/:id")
	def getUsuarioPorId() {
		return ok(RepoLocator.repoUsuario.searchById(Long.parseLong(id)).toJson)
	}

	@Get("/usuarios/id/:id/amigos")
	def getAmigosDeUsuarioPorId() {
		return ok(RepoLocator.repoUsuario.getUsuarioConAmigos(Long.parseLong(id)).listaDeAmigos.toJson)
	}

	@Put("/usuario/eliminarAmigo")
	def Result eliminarAmigo(@Body String body) {
		try {
			val idUsuario = body.getPropertyValue("idUsuarioLoggeado")
			val idAmigo = body.getPropertyValue("idAmigoAEliminar")
			val usuario = RepoLocator.repoUsuario.getUsuarioConAmigos(Long.parseLong(idUsuario))
			val amigo = RepoLocator.repoUsuario.searchById(Long.parseLong(idAmigo))
			usuario.eliminarAmigo(amigo)
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuarios/:id/porConocer")
	def getUsuariosNoAmigos() {
		val usuarioLogueado = RepoLocator.repoUsuario.getUsuarioConAmigos(Long.parseLong(id))
		return ok(RepoLocator.repoUsuario.allInstances.filter [ usuario |
			!usuarioLogueado.listaDeAmigos.contains(usuario) && !usuario.equals(usuarioLogueado)
		].toSet.toJson)
	}

	@Put('/usuarios/actualizarAmigosDe/:id')
	def Result actualizarAmigosDeUsuario(@Body String body) {
		try {
			val idLogueado = Long.parseLong(id)
			val actualizado = RepoLocator.repoUsuario.getUsuarioConAmigos(idLogueado)
			var listaDeids = body.getPropertyAsList("idsAmigos", Long)
			var Set<Usuario> listaDeAmigos = listaDeids.map [ cadaId |
				RepoLocator.repoUsuario.searchById(cadaId)
			].toSet
			listaDeAmigos.forEach[nuevoAmigo|actualizado.agregarAmigo(nuevoAmigo)]

			RepoLocator.repoUsuario.update(actualizado)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Post("/login")
	def Result login(@Body String body) {
		try {
			val ObjectMapper mapper = new ObjectMapper();
			val user = body.getPropertyValue("user")
			val pass = body.getPropertyValue("pass")
			val usuario = RepoLocator.repoUsuario.login(user, pass)
			val jsonUsuario = mapper.writeValueAsString(usuario)
			val String nuevoJson = jsonUsuario.substring(0, jsonUsuario.length() - 1);
			val jsonFinal = nuevoJson + ',"cantidadItemsCarrito":' + usuario.carrito.length + "}"
			ok(jsonFinal);
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/carrito/:id")
	def getCarritoUsuario() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.getUsuarioConCarritoCompleto(idUsuario)
			return ok(usuario.carrito.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/historial-pelis-vistas/:id")
	def getHistorialUsuario() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.getUsuarioConEntradas(idUsuario)
			return ok(usuario.getHistorial.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/cantidad-de-items-carrito/:id")
	def getCantidadDeItemsCarrito() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.getUsuarioConCarrito(idUsuario)
			return ok(usuario.carrito.length.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/finalizar-compra/:id")
	def Result finalizarCompra() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.getUsuarioConCarritoCompleto(idUsuario)
			usuario.finalizarCompra()
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/limpiar-carrito/:id")
	def Result limpiarCarrito() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			usuario.limpiarCarrito()
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/eliminar-item-carrito/:id")
	def Result eliminarItemCarrito(@Body String body) {
		try {
			val idUsuario = Long.parseLong(id)
			val idEntrada = Long.parseLong(body.getPropertyValue("idEntrada"))
			val entrada = RepoLocator.repoEntrada.searchById(idEntrada)
			val usuario = RepoLocator.repoUsuario.getUsuarioConCarrito(idUsuario)
			usuario.eliminarItem(entrada)
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/agregar-item-carrito/:id")
	def Result agregarItemCarrito(@Body String body) {
		try {
			val idUsuario = Long.parseLong(id)
			val idContenido = Long.parseLong(body.getPropertyValue("idContenido"))
			val idFuncion = Long.parseLong(body.getPropertyValue("idFuncion"))
			val contenido = RepoLocator.repoContenido.getContenidoConFunciones(idContenido)
			val funcion = contenido.searchFuncionById(idFuncion)
			val usuario = RepoLocator.repoUsuario.getUsuarioConCarrito(idUsuario)
			val entrada = new Entrada(contenido, funcion)
			RepoLocator.repoEntrada.create(entrada)
			usuario.agregarAlCarrito(entrada)
			RepoLocator.repoUsuario.update(usuario)

			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/:id/cargar-saldo/")
	def Result cargarSaldo(@Body String body) {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			val saldoACargar = Double.parseDouble(body.getPropertyValue("saldoACargar"))
			usuario.cargarSaldo(saldoACargar)
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/:id/actualizar/")
	def Result actualizarUsuario(@Body String body) {
		try {
			val idUsuario = Long.parseLong(id)
			var usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			usuario.edad = body.getPropertyAsInteger("edad")
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

}
