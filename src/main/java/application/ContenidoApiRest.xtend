package application

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import repositorios.RepoLocator

@Controller
class ContenidoApiRest {

	extension JSONUtils = new JSONUtils

	@Get("/cartelera")
	def Result getContenidoEnCartelera() {
		try {
			return ok(RepoLocator.repoContenido.pool.toList.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/recomendaciones")
	def Result getContenidoRecomendado() {
		try {
			return ok(RepoLocator.repoContenido.pool.toList.subList(4, 7).toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/funciones/:id")
	def Result getFuncionesByIdContenido() {
		try {
			val contenido = RepoLocator.repoContenido.searchById(Integer.parseInt(id))
			return ok(contenido.funciones.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

}
