package persistencia

import domain.Pelicula
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorios.RepoContenido
import repositorios.RepoLocator

class TestPersistenciaContenido {
	RepoContenido repoContenido
	Pelicula matrix

	@Before
	def void init() {
		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999, "")
		repoContenido = RepoLocator.repoContenido
		repoContenido.create(matrix)
	}

	@Test
	def seCreaPelicula() {
		val matrixBD = repoContenido.searchById(matrix.id)
		Assert.assertEquals(matrix, matrixBD)
	}

	@Test
	def seActualizaPelicula() {
		matrix.genero = "Test"
		repoContenido.update(matrix)
		val matrixBD = repoContenido.searchById(matrix.id)
		Assert.assertEquals("Test", matrixBD.genero)
	}

	@Test
	def seEliminaPelicula() {
		repoContenido.delete(matrix)
		val matrixBD = repoContenido.searchById(matrix.id)
		Assert.assertEquals(null, matrixBD)
	}

	@After
	def void end() {
		repoContenido.delete(matrix)
	}
}
