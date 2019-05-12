package repositorios

import com.mongodb.MongoClient
import domain.Contenido
import domain.Funcion
import domain.Pelicula
import domain.Saga
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.bson.types.ObjectId

abstract class RepoDocumental<T> {

	static protected Datastore ds

	new() {
		if (ds === null) {
			val mongo = new MongoClient("localhost", 27017)
			new Morphia => [
				map(Contenido).map(Funcion).map(Saga).map(Pelicula)
				ds = createDatastore(mongo, "tpJoits")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

	def T create(T t) {
		ds.save(t)
		t
	}

	def void delete(T t) {
		ds.delete(t)
	}

	def T searchById(ObjectId id)

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}
