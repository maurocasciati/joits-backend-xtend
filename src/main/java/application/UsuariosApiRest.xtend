package application

import domain.Usuario
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
		return ok(RepoLocator.repoUsuario.busqueda(nombre).toJson)
	}

	@Get("/usuarios/id/:id")
	def getUsuarioPorId() {
		return ok(RepoLocator.repoUsuario.searchById(Integer.parseInt(id)).toJson)
	}

	@Get("/usuarios/id/:id/amigos")
	def getAmigosDeUsuarioPorId() {
		return ok(RepoLocator.repoUsuario.searchById(Integer.parseInt(id)).listaDeAmigos.toJson)
	}

	@Put("/usuario/eliminarAmigo")
	def Result eliminarAmigo(@Body String body) {
		try {
			val idUsuario = body.getPropertyValue("idUsuarioLoggeado")
			val idAmigo = body.getPropertyValue("idAmigoAEliminar")
			val usuario = RepoLocator.repoUsuario.searchById(Integer.parseInt(idUsuario))
			val amigo = RepoLocator.repoUsuario.searchById(Integer.parseInt(idAmigo))
			usuario.eliminarAmigo(amigo)
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

			RepoLocator.repoUsuario.updateRecord(actualizado)
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
			ok(RepoLocator.repoUsuario.getUsuario(user, pass).id.toJson);
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/usuario/carrito/:id")
	def getCarritoUsuario() {
		try {
			val idUsuario = Integer.parseInt(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			return ok(usuario.carrito.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/finalizar-compra/:id")
	def Result finalizarCompra() {
		try {
			val idUsuario = Integer.parseInt(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			usuario.finalizarCompra()
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/limpiar-carrito/:id")
	def Result limpiarCarrito() {
		try {
			val idUsuario = Integer.parseInt(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			usuario.limpiarCarrito()
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Put("/usuario/eliminar-item-carrito/:id")
	def Result eliminarItemCarrito(@Body String body) {
		try {
			val idUsuario = Integer.parseInt(id)
			val idEntrada = Integer.parseInt(body.getPropertyValue("idEntrada"))
			val entrada = RepoLocator.repoEntrada.searchById(idEntrada)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			usuario.eliminarItem(entrada)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	
	@Put("/usuario/agregar-item-carrito/:id")
	def Result agregarItemCarrito(@Body String body) {
		try {
			val idUsuario = Integer.parseInt(id)
			val idContenido = Integer.parseInt(body.getPropertyValue("idContenido"))
			val idFuncion = Integer.parseInt(body.getPropertyValue("idFuncion"))
			
			val contenido = RepoLocator.repoContenido.searchById(idContenido)
			val funcion = contenido.searchFuncionById(idFuncion)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			usuario.agregarAlCarrito(contenido,funcion)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	
	@Put("/usuario/:id/cargar-saldo/")
	def Result cargarSaldo(@Body String body) {
		try {
			val idUsuario = Integer.parseInt(id)
			val usuario = RepoLocator.repoUsuario.searchById(idUsuario)
			val saldoACargar = Double.parseDouble(body.getPropertyValue("saldoACargar"))
			usuario.cargarSaldo(saldoACargar)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

}
