package persistencia

import domain.Entrada
import java.time.LocalDateTime
import java.time.Month
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorios.RepoEntrada
import repositorios.RepoLocator

class TestPersistenciaEntrada {
	RepoEntrada repoEntrada
	Entrada entrada

	@Before
	def void init() {
		repoEntrada = RepoLocator.repoEntrada
		entrada = new Entrada
		repoEntrada.create(entrada)
	}

	@Test
	def seCreaEntrada() {
		val entradaDB = repoEntrada.searchById(entrada.id)
		Assert.assertEquals(entrada, entradaDB)
	}

	@Test
	def seActualizaEntrada() {
		val fecha = (LocalDateTime.of(2019, Month.JUNE, 5, 11, 25, 00))
		entrada.fechaCompra = fecha
		repoEntrada.update(entrada)
		val entradaDB = repoEntrada.searchById(entrada.id)
		Assert.assertEquals(fecha, entradaDB.fechaCompra)
	}

	@Test
	def seEliminaEntrada() {
		repoEntrada.delete(entrada)
		val entradaDB = repoEntrada.searchById(entrada.id)
		Assert.assertEquals(null, entradaDB)
	}

	@After
	def void end() {
		repoEntrada.delete(entrada)
	}
}
