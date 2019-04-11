package repositorios

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@TransactionalAndObservable
abstract class Repositorio<T>{
	
	def abstract Class<T> getEntityType()

	def allInstances() {}
	
	def create(T t){}
}
