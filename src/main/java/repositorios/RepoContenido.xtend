package repositorios

import domain.Contenido
import org.bson.types.ObjectId
import org.mongodb.morphia.query.Query

class RepoContenido extends RepoDocumental<Contenido> {

	static RepoContenido instance

	def static getInstance() {
		if (instance === null) {
			instance = new RepoContenido
		}
		instance
	}

	override getEntityType() {
		Contenido
	}

	def getCount() {
		ds.getCount(Contenido)
	}

	override searchById(ObjectId id) {
		ds.get(Contenido, id)
	}

	def searchByTitle(String titulo) {
		var Query<Contenido> query = ds.createQuery(Contenido)
		query.criteria("titulo").equal(titulo)
		query.asList.head

	}

}
