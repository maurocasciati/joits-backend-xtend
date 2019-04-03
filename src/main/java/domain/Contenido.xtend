package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorios.Entidad
import com.fasterxml.jackson.annotation.JsonIgnore

@Accessors
@Observable
abstract class Contenido extends Entidad {

	String titulo
	Double puntaje
	String genero // accion, comedia, drama, ciencia ficcion	
	@JsonIgnore List<Funcion> funciones = new ArrayList<Funcion>

	def Double precio()

	def Integer getAnio()
}
