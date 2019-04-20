package memoria

import domain.Funcion
import java.time.LocalDateTime
import java.time.Month
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestFuncion extends SuperTest {

	Funcion funcionMiercoles
	Funcion funcionSabado
	Funcion funcionRegular

	@Before
	def void initialize() {
		super.init()
		inicializarFunciones
	}

	def inicializarFunciones() {
		funcionMiercoles = new Funcion(LocalDateTime.of(2019, Month.APRIL, 10, 18, 00, 00), "Cinemark Palermo")
		funcionSabado = new Funcion(LocalDateTime.of(2019, Month.APRIL, 20, 12, 30, 00), "Hoyts Unicenter")
		funcionRegular = new Funcion(LocalDateTime.of(2019, Month.APRIL, 15, 17, 15, 00), "Cine Gaumont")
	}

	@Test
	def funcionQueEsMiercoles() {
		Assert.assertTrue(funcionMiercoles.esMiercoles)
	}

	@Test
	def funcionQueElFinDeSemana() {
		Assert.assertTrue(funcionSabado.esFinDeSemana)
	}

	@Test
	def funcionQueNoEsMiercolesNiFinDeSemana() {
		Assert.assertTrue(!funcionRegular.esMiercoles && !funcionRegular.esFinDeSemana)
	}

	@Test
	def funcionQueEsMiercolesCuesta50() {
		Assert.assertEquals(50.0, funcionMiercoles.precio, 0)
	}

	@Test
	def funcionQueEsElFinDeSemanaCuesta120() {
		Assert.assertEquals(120.0, funcionSabado.precio, 0)
	}

	@Test
	def funcionQueNoEsMiercolesNiFinDeCuesta80() {
		Assert.assertEquals(80.0, funcionRegular.precio, 0)
	}

}
