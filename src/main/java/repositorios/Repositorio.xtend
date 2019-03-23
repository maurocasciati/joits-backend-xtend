package repositorios

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
abstract class Repositorio<T extends Entidad> {
	@Accessors List<T> pool = new ArrayList

	def void create(T object) {
		if (validaNoExistePreviamenteEnRepo(object)) {
			addId(object)
			pool.add(object)
		} else {
			updateRecord(object)
		}
	}
	
	def void addId(T object) {

		object.id = getNextFreeId
	}

	def int getNextFreeId() {
		var int id
		if (pool.isEmpty) {
			id = 0
		} else {
			id = pool.stream.mapToInt(object|object.id).max.asInt + 1
		}
		return id
	}

	def void delete(T object) {
		pool.remove(object)
	}

	def void updateRecord(T object)

	def T searchById(int id) {
		// lanzar una excepción si no se encuentra
		pool.findFirst[object|object.id == id]
	}

//	def List<T> search(String value)

	def boolean validaNoExistePreviamenteEnRepo(Entidad object) {
		!pool.contains(object)
	}

//	def String retrieveAllObjects()

}
