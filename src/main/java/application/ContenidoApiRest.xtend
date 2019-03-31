package application

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import repositorios.RepoLocator
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.api.Result
import domain.Usuario

@Controller
class ContenidoApiRest {

	extension JSONUtils = new JSONUtils

	@Get("/cartelera")
	def Result getContenidoEnCartelera() {
		return ok(RepoLocator.repoContenido.pool.toList.toJson)
	}

	@Get("/funciones/:id")
	def Result getFuncionesByIdContenido() {
		val contenido = RepoLocator.repoContenido.searchById(Integer.parseInt(id))
		return ok(contenido.funciones.toJson)
	}

}
