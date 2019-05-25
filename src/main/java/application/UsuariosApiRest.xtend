package application

import com.fasterxml.jackson.databind.ObjectMapper
import domain.Carrito
import domain.Item
import domain.Usuario
import java.util.ArrayList
import java.util.Set
import org.bson.types.ObjectId
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
		val idLogueado = Long.parseLong(id)
		return ok(RepoLocator.repoUsuario.getNoAmigosDeUsuario(idLogueado).toSet.toJson)
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
			ok(jsonUsuario);
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/carrito/:id")
	def getCarritoUsuario() {
		try {
			val carrito = RepoLocator.repoCarrito.getCarritoByUserId(id)
			return ok(carrito.toJson)
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

	@Put("/usuario/finalizar-compra/:id")
	def Result finalizarCompra(@Body String body) {
		try {
			val idUsuario = Long.parseLong(id)
			var usuario = RepoLocator.repoUsuario.getUsuarioConEntradas(idUsuario)
			val carrito = RepoLocator.repoCarrito.getCarritoByUserId(id)
			usuario.finalizarCompra(carrito)
			RepoLocator.repoCarrito.limpiarCarrito(idUsuario.toString)
			RepoLocator.repoUsuario.update(usuario)
			return ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/limpiar-carrito/:id")
	def Result limpiarCarrito() {
		try {
			val idUsuario = Long.parseLong(id)
			RepoLocator.repoCarrito.limpiarCarrito(idUsuario.toString)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/eliminar-item-carrito/:id")
	def Result eliminarItemCarrito(@Body String body) {
		try {
			var idUsuario = id
			var idContenido = body.getPropertyValue("id_contenido")
			val idFuncion = Integer.parseInt(body.getPropertyValue("id_funcion"))
			var contenido = RepoLocator.repoContenido.searchById(new ObjectId(idContenido))
			var funcion = contenido.funciones.findFirst[funcion|funcion.id == idFuncion]
			var carrito = RepoLocator.repoCarrito.getCarritoByUserId(idUsuario.toString)
			var item = new Item(contenido, funcion)
			carrito.eliminarItem(item)
			RepoLocator.repoCarrito.guardarCarrito(id, carrito)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/agregar-item-carrito/:id")
	def Result agregarItemCarrito(@Body String body) {
		try {
			var idContenido = body.getPropertyValue("id_contenido")
			val idFuncion = Integer.parseInt(body.getPropertyValue("id_funcion"))
			var contenido = RepoLocator.repoContenido.searchById(new ObjectId(idContenido))
			var funcion = contenido.funciones.findFirst[funcion|funcion.id == idFuncion]
			var carrito = RepoLocator.repoCarrito.getCarritoByUserId(id)
			var item = new Item(contenido, funcion)
			carrito.agregarAlCarrito(item)
			RepoLocator.repoCarrito.guardarCarrito(id, carrito)
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
