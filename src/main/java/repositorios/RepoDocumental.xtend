package repositorios

import com.mongodb.MongoClient
import domain.Contenido
import domain.Funcion
import domain.Pelicula
import domain.Saga
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.UpdateOperations

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

	def T getByExample(T example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		}
	}

	def List<T> searchByExample(T t)

	def T createIfNotExists(T t) {
		val entidadAModificar = getByExample(t)
		if (entidadAModificar !== null) {
			return entidadAModificar
		}
		create(t)
	}

	def void update(T t) {
		ds.update(t, this.defineUpdateOperations(t))
	}

	abstract def UpdateOperations<T> defineUpdateOperations(T t)

	def T create(T t) {
		ds.save(t)
		t
	}

	def void delete(T t) {
		ds.delete(t)
	}

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}