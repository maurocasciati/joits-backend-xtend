package domain

import repositorios.Entidad
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import java.util.ArrayList
import com.fasterxml.jackson.annotation.JsonIgnore

@Accessors
@Observable
abstract class Contenido extends Entidad {

	String titulo
	Double puntaje
	String genero // accion, comedia, drama, ciencia ficcion	
	List<Funcion> funciones = new ArrayList<Funcion>

	def Double precio()

	def Integer getAnio()
}
