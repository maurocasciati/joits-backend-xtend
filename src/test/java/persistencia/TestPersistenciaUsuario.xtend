package persistencia

import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Usuario
import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.Month
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorios.FetchNothing
import repositorios.FetchUsuarioConAmigosYEntradas
import repositorios.FetchUsuarioConCarrito
import repositorios.FetchUsuarioConCarritoCompleto
import repositorios.RepoContenido
import repositorios.RepoEntrada
import repositorios.RepoFuncion
import repositorios.RepoLocator
import repositorios.RepoUsuario

class TestPersistenciaUsuario {

	RepoContenido repoContenido
	RepoUsuario repoUsuarios
	RepoEntrada repoEntradas
	RepoFuncion repoFunciones
	Usuario aniston
	Usuario deNiro
	Pelicula matrix
	Entrada entrada
	Funcion funcion

	@Before
	def void init() {
		inicializarRepos
		crearContenido
		inicializarUsuarios
		crearFunciones
		crearEntradas
	}

	def inicializarRepos() {
		repoUsuarios = RepoLocator.repoUsuario
		repoContenido = RepoLocator.repoContenido
		repoEntradas = RepoLocator.repoEntrada
		repoFunciones = RepoLocator.repoFuncion
	}

	def inicializarUsuarios() {

		aniston = new Usuario => [
			nombre = "Jennifer"
			apellido = "Aniston"
			username = "rachel_g"
			edad = 50
			saldo = new BigDecimal("330")
			setPasswordHash = "3FBDD18C7FBF4323800765BEABE2EFD37FC1233B0E18AD8F271AC76B7517E304"
		]

		deNiro = new Usuario => [
			nombre = "Robert"
			apellido = "De Niro"
			username = "robertito"
			edad = 75
			saldo = new BigDecimal("964")
			setPasswordHash = "72534C4A93DDC043FE3229ED46B1D526C4CCC747FEBDCD0F284F7F6057A37858"
		]

		repoUsuarios.create(aniston)
		repoUsuarios.create(deNiro)
	}

	def crearContenido() {
		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999, "")
		repoContenido.create(matrix)
	}

	def crearFunciones() {
		funcion = new Funcion(LocalDateTime.of(2019, Month.DECEMBER, 22, 15, 00, 00), "Cinemark Palermo")
		repoFunciones.create(funcion)
	}

	def crearEntradas() {
		entrada = new Entrada(matrix, funcion)

		repoEntradas.create(entrada)
	}

	@Test
	def seCreaUsuario() {
		Assert.assertEquals(repoUsuarios.searchById(aniston.id, new FetchNothing), aniston)
	}

	@Test
	def seEliminaUsuario() {
		repoUsuarios.delete(aniston)
		val anistonDB = repoUsuarios.searchById(aniston.id, new FetchNothing)
		Assert.assertEquals(null, anistonDB)
	}

	@Test
	def unUsuarioAgregaAUnAmigo() {
		aniston.agregarAmigo(deNiro)
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConAmigosYEntradas)
		Assert.assertTrue(anistonActualizada.listaDeAmigos.contains(deNiro))
	}

	@Test
	def unUsuarioCargaSaldo() {
		val BigDecimal saldoAnterior = aniston.saldo
		aniston.cargarSaldo(50.7)
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id, new FetchNothing)
		Assert.assertTrue((saldoAnterior + new BigDecimal("50.7")).compareTo(anistonActualizada.saldo) == 0)
	}

	@Test
	def unUsuarioCambiaEdad() {
		aniston.edad = 45
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id, new FetchNothing)
		Assert.assertEquals(45, anistonActualizada.edad)
	}

	@Test
	def unUsuarioAgregaEntradaAlCarrito() {
		aniston.agregarAlCarrito(entrada)
		repoUsuarios.update(aniston)
		val anistonConCarritoActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConCarrito)
		Assert.assertTrue(anistonConCarritoActualizada.carrito.contains(entrada))
	}

	@Test
	def unUsuarioLimpiaCarrito() {
		aniston.limpiarCarrito
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConCarrito)
		Assert.assertTrue(anistonActualizada.carrito.length == 0)
	}

	@Test
	def unUsuarioFinalizaCompra() {
		val totalCompra = new BigDecimal(aniston.totalCarrito)
		aniston.finalizarCompra
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConCarritoCompleto)
		Assert.assertTrue((aniston.saldo - totalCompra).compareTo(anistonActualizada.saldo) == 0)
	}

	@Test
	def unUsuarioEliminaItemDelCarrito() {
		aniston.agregarAlCarrito(entrada)
		aniston.eliminarItem(entrada)
		repoUsuarios.update(aniston)
		val anistonConCarritoActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConCarrito)
		Assert.assertTrue(!anistonConCarritoActualizada.carrito.contains(entrada))
	}

	@After
	def void end() {
		repoUsuarios.delete(aniston)
		repoUsuarios.delete(deNiro)
		repoEntradas.delete(entrada)
		repoFunciones.delete(funcion)
		repoContenido.delete(matrix)
	}
}
