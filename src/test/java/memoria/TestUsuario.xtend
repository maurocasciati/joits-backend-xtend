package memoria

import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Saga
import domain.Usuario
import java.math.BigDecimal
import java.util.ArrayList
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import java.time.LocalDateTime
import java.time.Month
import org.uqbar.commons.model.exceptions.UserException

class TestUsuario {

	Usuario aniston
	Usuario deNiro
	Pelicula matrix
	Pelicula matrix2
	Pelicula matrix3
	Saga sagaMatrix
	Pelicula pulpFiction
	Funcion funcion
	Entrada entrada

	@Before
	def void init() {
		crearContenido
		inicializarUsuarios
		crearEntradas
	}

	def crearEntradas() {
		entrada = new Entrada => [
			contenido = matrix
		]
		entrada.funcion = new Funcion(LocalDateTime.of(2019, Month.APRIL, 29, 18, 00, 00), "Hoyts Unicenter")
	}

	def inicializarUsuarios() {

		aniston = new Usuario => [
			nombre = "Jennifer"
			apellido = "Aniston"
			username = "rachel_g"
			edad = 50
			saldo = new BigDecimal("330")
			contrasenia = "jen123"
		]

		deNiro = new Usuario => [
			nombre = "Robert"
			apellido = "De Niro"
			username = "robertito"
			edad = 75
			saldo = new BigDecimal("964")
			contrasenia = "roberto"
		]

	}

	def crearContenido() {

		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999)
		matrix2 = new Pelicula("The Matrix: Reloaded", 7.2, "Ciencia Ficción", 2003)
		matrix3 = new Pelicula("The Matrix: Revolution", 6.7, "Ciencia Ficción", 2003)
		pulpFiction = new Pelicula("Pulp Fiction", 8.9, "Drama", 1994)

		sagaMatrix = new Saga => [
			titulo = "Saga Matrix"
			puntaje = 7.5
			genero = "Ciencia Ficción"
			anioRecopilacion = 2007
			nivelClasico = 120
			peliculas = new ArrayList<Pelicula>
			peliculas.addAll(matrix, matrix2, matrix3)
		]

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

	@Test
	def unUsuarioAgregaEntradaAlCarrito() {
		aniston.agregarAlCarrito(entrada)
		Assert.assertTrue(aniston.carrito.contains(entrada))
	}

	@Test
	def unUsuarioLimpiaCarrito() {
		aniston.limpiarCarrito
		Assert.assertTrue(aniston.carrito.isEmpty)
	}

	@Test
	def unUsuarioFinalizaCompra() {
		val totalCompra = new BigDecimal(aniston.totalCarrito)
		aniston.finalizarCompra
		Assert.assertTrue((aniston.saldo - totalCompra).compareTo(aniston.saldo) == 0)
	}

	@Test
	def unUsuarioEliminaItemDelCarrito() {
		aniston.agregarAlCarrito(entrada)
		aniston.eliminarItem(entrada)
		Assert.assertTrue(!aniston.carrito.contains(entrada))
	}

	@Test(expected=UserException)
	def void unUsuarioQuiereFinalizarCompraPeroNoLeAlcanzaElSaldo() {
		aniston.saldo = new BigDecimal("0")
		aniston.agregarAlCarrito(entrada)
		aniston.finalizarCompra
	}
}
