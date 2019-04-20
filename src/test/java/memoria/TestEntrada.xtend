package memoria

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestEntrada extends SuperTest {
	@Before
	def void initialize() {
		super.init()
	}

	@Test
	def entradaParaPeliculaUnMiercolesCuesta80() {
		entrada.funcion = funcionMiercoles
		Assert.assertEquals(80, entrada.precio, 0)
	}

	@Test
	def entradaParaPeliculaUnSabadoCuesta150() {
		entrada.funcion = funcionSabado
		Assert.assertEquals(150, entrada.precio, 0)
	}

	@Test
	def entradaParaPeliculaUnDiaRegularCuesta110() {
		entrada.funcion = funcionRegular
		Assert.assertEquals(110, entrada.precio, 0)
	}

	@Test
	def entradaParaSagaDe3PeliculasYNivelDeClasico120UnMiercolesCuesta200() {
		entrada.funcion = funcionMiercoles
		entrada.contenido = sagaMatrix
		Assert.assertEquals(200, entrada.precio, 0)
	}

}
