package repositorios

import domain.Contenido
import org.bson.types.ObjectId

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
	
	def getCount(){
		ds.getCount(Contenido)
	}
	
	override searchById(ObjectId id) {
		ds.get(Contenido, id)
	}
	
}


