package application

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import repositorios.RepoLocator
import org.bson.types.ObjectId

@Controller
class ContenidoApiRest {

	extension JSONUtils = new JSONUtils

	@Get("/cartelera")
	def Result getContenidoEnCartelera() {
		try {
			return ok(RepoLocator.repoContenido.allInstances.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/recomendaciones/:id")
	def Result getContenidoRecomendado() {
		try {
			return ok(RepoLocator.repoUsuarioNeo.peliculasRecomendadas(Long.parseLong(id)).toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Get("/funciones/:id")
	def Result getFuncionesByIdContenido() {
		try {
			val objectId = new ObjectId(id)
			val contenido = RepoLocator.repoContenido.searchById(objectId)
			return ok(contenido.funciones.toJson)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

}
