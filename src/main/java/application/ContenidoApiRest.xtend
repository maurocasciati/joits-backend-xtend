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
		return ok(RepoLocator.repoContenido.pool.toList.toJson)
	}
	
	@Get("/recomendaciones")
	def Result getContenidoRecomendado() {
		return ok(RepoLocator.repoContenido.pool.toList.subList(4, 7).toJson)
	}

	@Get("/funciones/:id")
	def Result getFuncionesByIdContenido() {
		val contenido = RepoLocator.repoContenido.searchById(Integer.parseInt(id))
		return ok(contenido.funciones.toJson)
	}

}
