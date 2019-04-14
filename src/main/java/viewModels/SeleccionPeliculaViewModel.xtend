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
import domain.Usuario
import domain.Entrada

@Accessors
@Observable
class SeleccionPeliculaViewModel {

	Usuario usuarioLogueado
	LocalDate fechaHoy = LocalDate.now

	List<Contenido> peliculas = RepoLocator.getRepoContenido.allInstances as List<Contenido>
	Contenido peliculaSeleccionada
	Funcion funcionSeleccionada 
	Contenido peliculaFromDB

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

	@Dependencies("peliculaSeleccionada") // USO peliculaFromDB PARA EVITAR LLAMAR AL SETTER DE PELICULASELECCIONADA Y CAER EN LOOP
	def getFunciones() {
		if (peliculaSeleccionada !== null) {
			peliculaFromDB = RepoLocator.repoContenido.searchById(peliculaSeleccionada.id)
			peliculaFromDB.funciones.toList
		} else {
			new ArrayList()
		}
	}

	def agregarAlCarrito() {
		val entrada = new Entrada(peliculaSeleccionada, funcionSeleccionada)
//		RepoLocator.repoEntrada.create(entrada)
		usuarioLogueado.agregarAlCarrito(entrada)
	}

	def getCantidadItemsCarrito() {
		usuarioLogueado.carrito.size
	}

	@Dependencies("funcionSeleccionada")
	def getPrecioEntrada() {
		if (funcionSeleccionada === null) {
			""
		} else {
			"$" + funcionSeleccionada.precio.toString
		}

	}
	
}
