package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorios.Entidad

@Accessors
@Observable
abstract class Contenido extends Entidad {

	String titulo
	Double puntaje
	String genero // accion, comedia, drama, ciencia ficcion	
	List<Funcion> funciones = new ArrayList<Funcion>
	String imdbID

	def Double precio()

	def Integer getAnio()

	def searchFuncionById(Integer id) {
		funciones.findFirst[funcion|funcion.id == id]
	}

}
