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
import java.util.List
import java.util.ArrayList
import domain.Carrito
import domain.Funcion
import java.util.HashSet
import org.bson.types.ObjectId

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

//	@Get("/usuario/carrito/:id")
//	def getCarritoUsuario() {
//		try {
//			val idUsuario = Long.parseLong(id)
//			val usuario = RepoLocator.repoUsuario.getUsuarioConCarritoCompleto(idUsuario)
//			return ok(usuario.carrito.toJson)
//		} catch (Exception e) {
//			badRequest(e.message)
//		}
//	}
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
			println(usuario.saldo)
			val carrito = obtenerCarrito(body)
			usuario.finalizarCompra(carrito)
			RepoLocator.repoUsuario.update(usuario)
			val usuario2 = RepoLocator.repoUsuario.searchById(idUsuario)
			println(usuario2.saldo)
			return ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	def obtenerCarrito(String body) {
		var i = 0
		var j = 1
		var Carrito carrito = new Carrito
		val stringEntradas = body.getPropertyValue("entradas")
		val List<Integer> entradasIds = stringEntradas.fromJson(ArrayList)
		var Set<Funcion> funciones = new HashSet<Funcion>
		while (i < entradasIds.size) {
			val idContenido = String.valueOf(entradasIds.get(i))
			val idFuncion = new Long(entradasIds.get(j))
			val objectId = new ObjectId(idContenido)
			val contenido = RepoLocator.repoContenido.searchById(objectId)
			val funcion = contenido.searchFuncionById(idFuncion)
			var Entrada entrada
			if (funciones.contains(funcion)) {
				val funcionExistente = funciones.findFirst(func|func.id == funcion.id)
				entrada = new Entrada(contenido, funcionExistente)
			}
			if (!funciones.contains(funcion)) {
				funciones.add(funcion)
				entrada = new Entrada(contenido, funcion)
			}
			carrito.agregarAlCarrito(entrada)
			i = i + 2
			j = j + 2
		}
		carrito
	}

//	@Put("/usuario/limpiar-carrito/:id")
//	def Result limpiarCarrito() {
//		try {
//			val idUsuario = Long.parseLong(id)
//			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
//			usuario.limpiarCarrito()
//			RepoLocator.repoUsuario.update(usuario)
//			ok('{ "status" : "OK" }');
//		} catch (Exception e) {
//			badRequest(e.message)
//		}
//	}
//	@Put("/usuario/eliminar-item-carrito/:id")
//	def Result eliminarItemCarrito(@Body String body) {
//		try {
//			val idUsuario = Long.parseLong(id)
//			val idEntrada = Long.parseLong(body.getPropertyValue("idEntrada"))
//			val usuario = RepoLocator.repoUsuario.getUsuarioConCarrito(idUsuario)
//			RepoLocator.repoUsuario.update(usuario)
//			ok('{ "status" : "OK" }');
//		} catch (Exception e) {
//			badRequest(e.message)
//		}
//	}
//	@Put("/usuario/agregar-item-carrito/:id")
//	def Result agregarItemCarrito(@Body String body) {
//		try {
//			val idUsuario = Long.parseLong(id)
//			val idContenido = Long.parseLong(body.getPropertyValue("idContenido"))
//			val idFuncion = Long.parseLong(body.getPropertyValue("idFuncion"))
//			val contenido = RepoLocator.repoContenido.getContenidoConFunciones(idContenido)
//			val funcion = contenido.searchFuncionById(idFuncion)
//			val usuario = RepoLocator.repoUsuario.getUsuarioConCarrito(idUsuario)
//			val entrada = new Entrada(contenido, funcion)
//			usuario.agregarAlCarrito(entrada)
//			RepoLocator.repoUsuario.update(usuario)
//
//			ok('{ "status" : "OK" }');
//		} catch (Exception e) {
//			badRequest(e.message)
//		}
//	}
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
