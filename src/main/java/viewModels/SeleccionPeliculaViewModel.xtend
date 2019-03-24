package viewModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.time.LocalDate
import java.util.List
import domain.Contenido
import repositorios.RepoLocator
import domain.Funcion
import java.util.ArrayList
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@Observable
class SeleccionPeliculaViewModel {

	String usuarioLogueado = "Mauro Casciati"
	LocalDate fechaHoy = LocalDate.now

	List<Contenido> peliculas = RepoLocator.getRepoContenido.pool
	List<Funcion> carrito = new ArrayList()
	Contenido peliculaSeleccionada
	Funcion funcionSeleccionada

	String valorDeBusqueda = null

	def getResultadoBusqueda() {
		peliculas.filter [ contenido |
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
		getResultadoBusqueda.subList(4, 7)
	}

	@Dependencies("peliculaSeleccionada")
	def getFunciones() {
		if (peliculaSeleccionada !== null) {
			peliculaSeleccionada.funciones.toList
		} else {
			new ArrayList()
		}

	}

	def agregarAlCarrito() {
		carrito.add(funcionSeleccionada)
	}

	@Dependencies("carrito")
	def getCantidadItemsCarrito() {
		carrito.size
	}

}
