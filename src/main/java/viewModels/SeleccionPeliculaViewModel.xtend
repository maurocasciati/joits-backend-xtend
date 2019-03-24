package viewModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.time.LocalDate
import java.util.List
import domain.Contenido
import repositorios.RepoLocator
import domain.Funcion

@Accessors
@Observable
class SeleccionPeliculaViewModel {
	
	String usuarioNuevo = "Mauro Casciati"
	LocalDate fechaHoy = LocalDate.now
	
	List<Contenido> peliculas = RepoLocator.getRepoContenido.pool
	Contenido peliculaSeleccionada = getResultadoBusqueda.get(0)
	Funcion funcionSeleccionada
	
	String valorDeBusqueda = null
	
	def getResultadoBusqueda() {
		peliculas.filter[contenido|
			this.match(valorDeBusqueda, contenido.titulo)
		].toList
	}

	def match(Object expectedValue, Object realValue) {
		if (expectedValue === null) {
			return true
		}
		if (realValue === null) {
			return false
		}
		realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}
	
	def getPeliculasRecomendadas() {
		getResultadoBusqueda
	}
	
	def getFunciones() {
		peliculaSeleccionada.funciones.toList
	}
}