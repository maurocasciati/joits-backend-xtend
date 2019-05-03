package memoria

import java.math.BigDecimal
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.commons.model.exceptions.UserException

class TestUsuario extends SuperTest {

	@Before
	def void initialize() {
		super.init()
	}

	@Test
	def unUsuarioAgregaAUnAmigo() {
		aniston.agregarAmigo(deNiro)
		Assert.assertTrue(aniston.listaDeAmigos.contains(deNiro))
	}

	@Test
	def unUsuarioCargaSaldo() {
		val BigDecimal saldoAnterior = aniston.saldo
		aniston.cargarSaldo(50.7)
		Assert.assertTrue((saldoAnterior + new BigDecimal("50.7")).compareTo(aniston.saldo) == 0)
	}

	@Test
	def unUsuarioCambiaEdad() {
		aniston.edad = 45
		Assert.assertEquals(45, aniston.edad)
	}

//	@Test
//	def unUsuarioAgregaEntradaAlCarrito() {
//		aniston.agregarAlCarrito(entrada)
//		Assert.assertTrue(aniston.carrito.contains(entrada))
//	}
//
//	@Test
//	def unUsuarioLimpiaCarrito() {
//		aniston.limpiarCarrito
//		Assert.assertTrue(aniston.carrito.isEmpty)
//	}
	@Test
	def unUsuarioFinalizaCompra() {
		val totalCompra = new BigDecimal(carrito.totalCarrito)
		val saldoAnterior = new BigDecimal(aniston.saldo.toString)
		aniston.finalizarCompra(carrito)
		Assert.assertTrue((saldoAnterior - totalCompra).compareTo(aniston.saldo) == 0)
	}

//	@Test
//	def unUsuarioEliminaItemDelCarrito() {
//		aniston.agregarAlCarrito(entrada)
//		aniston.eliminarItem(entrada)
//		Assert.assertTrue(!aniston.carrito.contains(entrada))
//	}
	@Test(expected=UserException)
	def void unUsuarioQuiereFinalizarCompraPeroNoLeAlcanzaElSaldo() {
		aniston.saldo = new BigDecimal("0")
		aniston.finalizarCompra(carrito)
	}
}
