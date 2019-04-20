package memoria

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class TestFuncion extends SuperTest {

	@Before
	def void initialize() {
		super.init()
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
