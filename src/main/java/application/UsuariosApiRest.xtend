package application

import domain.Entrada
import domain.Usuario
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import repositorios.FetchContenidoConFunciones
import repositorios.FetchNothing
import repositorios.FetchUsuarioConAmigos
import repositorios.FetchUsuarioConCarrito
import repositorios.FetchUsuarioConCarritoCompleto
import repositorios.RepoLocator
import repositorios.FetchUsuarioConEntradas

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
		return ok(RepoLocator.repoUsuario.searchById(Long.parseLong(id), new FetchUsuarioConAmigos).toJson)
	}

	@Get("/usuarios/id/:id/amigos")
	def getAmigosDeUsuarioPorId() {
		return ok(
			RepoLocator.repoUsuario.searchById(Long.parseLong(id), new FetchUsuarioConAmigos).listaDeAmigos.toJson)
	}

	@Put("/usuario/eliminarAmigo")
	def Result eliminarAmigo(@Body String body) {
		try {
			val idUsuario = body.getPropertyValue("idUsuarioLoggeado")
			val idAmigo = body.getPropertyValue("idAmigoAEliminar")
			val usuario = RepoLocator.repoUsuario.searchById(Long.parseLong(idUsuario), new FetchUsuarioConAmigos)
			val amigo = RepoLocator.repoUsuario.searchById(Long.parseLong(idAmigo), new FetchUsuarioConAmigos)
			usuario.eliminarAmigo(amigo)
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put('/usuarios/id/:id')
	def Result actualizarUsuario(@Body String body) {
		try {
			val actualizado = body.fromJson(Usuario)

			if (Integer.parseInt(id) != actualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}

			RepoLocator.repoUsuario.update(actualizado)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Post("/login")
	def Result login(@Body String body) {
		try {
			val user = body.getPropertyValue("user")
			val pass = body.getPropertyValue("pass")
			ok(RepoLocator.repoUsuario.login(user, pass).id.toJson);
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/carrito/:id")
	def getCarritoUsuario() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchUsuarioConCarritoCompleto)
			return ok(usuario.carrito.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/historial-pelis-vistas/:id")
	def getHistorialUsuario() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchUsuarioConEntradas)
			return ok(usuario.getHistorial.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/cantidad-de-items-carrito/:id")
	def getCantidadDeItemsCarrito() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchUsuarioConCarrito)
			return ok(usuario.carrito.length.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/finalizar-compra/:id")
	def Result finalizarCompra() {
		try {
			val idUsuario = Long.parseLong(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchUsuarioConCarritoCompleto)
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
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchUsuarioConCarrito)
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
			val entrada = RepoLocator.repoEntrada.searchById(idEntrada, new FetchNothing)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchUsuarioConCarrito)
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
			val contenido = RepoLocator.repoContenido.searchById(idContenido, new FetchContenidoConFunciones)
			val funcion = contenido.searchFuncionById(idFuncion)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchUsuarioConCarrito)
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
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario, new FetchNothing)
			val saldoACargar = Double.parseDouble(body.getPropertyValue("saldoACargar"))
			usuario.cargarSaldo(saldoACargar)
			RepoLocator.repoUsuario.update(usuario)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

}
