package repositorios

import org.bson.types.ObjectId
import domain.Funcion

class RepoFuncion extends RepoDocumental<Funcion> {

	static RepoFuncion instance

	def static getInstance() {
		if (instance === null) {
			instance = new RepoFuncion
		}
		instance
	}

	override getEntityType() {
		Funcion
	}

	override searchById(ObjectId id) {
		ds.get(Funcion, id)
	}

}
