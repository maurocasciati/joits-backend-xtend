package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.ArrayList
import java.util.List
import java.util.Objects
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
@Entity("contenido")
abstract class Contenido {
	@JsonIgnore
	@Id ObjectId id

	String titulo
	Double puntaje
	String genero
	String apiID

	@Embedded
	@JsonIgnore
	List<Funcion> funciones = new ArrayList<Funcion>


	def Double getPrecio()

	def Integer getAnio()

	def searchFuncionById(Long id) {
		funciones.findFirst[funcion|funcion.id == id]
	}

	@JsonProperty("id_contenido")
	def String getIdContenido() {
		id.toString
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
	
	def agregarFuncion(Funcion funcion){
		funcion.id = funciones.size
		funciones.add(funcion)
	}

}
