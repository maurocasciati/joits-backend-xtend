package persistencia

import domain.Funcion
import java.time.LocalDateTime
import java.time.Month
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorios.FetchNothing
import repositorios.RepoFuncion
import repositorios.RepoLocator

class TestPersistenciaFuncion {
	RepoFuncion repoFuncion
	Funcion funcion

	@Before
	def void init() {
		funcion = new Funcion(LocalDateTime.of(2019, Month.APRIL, 14, 15, 00, 00), "Cinemark Palermo")
		repoFuncion = RepoLocator.repoFuncion
		repoFuncion.create(funcion)
	}

	@Test
	def seCreaFuncion() {
		val funcionBD = repoFuncion.searchById(funcion.id, new FetchNothing)
		Assert.assertEquals(funcion, funcionBD)
	}

	@Test
	def seActualizaFuncion() {
		funcion.nombreSala = "Sala Test"
		repoFuncion.update(funcion)
		val funcionDB = repoFuncion.searchById(funcion.id, new FetchNothing)
		Assert.assertEquals("Sala Test", funcionDB.nombreSala)
	}

	@Test
	def seEliminaFuncion() {
		repoFuncion.delete(funcion)
		val funcionDB = repoFuncion.searchById(funcion.id, new FetchNothing)
		Assert.assertEquals(null, funcionDB)
	}

	@After
	def void end() {
		repoFuncion.delete(funcion)
	}
}
