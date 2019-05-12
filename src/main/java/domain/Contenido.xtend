package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import java.util.List
import java.util.Objects
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Property
import org.uqbar.commons.model.annotations.Observable
import org.mongodb.morphia.annotations.Embedded

@Observable
@Accessors
@Entity("contenidos")
abstract class Contenido {

	@Id ObjectId id

	@Property("titulo")
	String titulo
	
	@Property("puntaje")
	Double puntaje
	
	@Property("genero")
	String genero

	@Embedded
	@JsonIgnore
	List<Funcion> funciones = new ArrayList<Funcion>

	@Property("apiID")
	String apiID

	def Double getPrecio()

	def Integer getAnio()

	def searchFuncionById(Long id) {
		funciones.findFirst[funcion|funcion.id == id]
	}

	override equals(Object other) {
		if (other instanceof Contenido) {
			return (other as Contenido).id == id
		}
		false
	}

	override hashCode() {
		Objects.hashCode(id)
	}
	
}
