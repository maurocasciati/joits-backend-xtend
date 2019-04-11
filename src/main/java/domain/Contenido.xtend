package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
abstract class Contenido{
	@Id
	@GeneratedValue
	Long id

	String titulo
	Double puntaje
	String genero // accion, comedia, drama, ciencia ficcion	
	List<Funcion> funciones = new ArrayList<Funcion>
	String imdbID
	String trailerURL

	def Double precio()

	def Integer getAnio()

	def searchFuncionById(Long id) {
		funciones.findFirst[funcion|funcion.id == id]
	}

}
