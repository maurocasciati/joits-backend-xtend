package persistencia

import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Saga
import domain.Usuario
import java.math.BigDecimal
import java.util.ArrayList
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorios.FetchNothing
import repositorios.FetchUsuarioConAmigos
import repositorios.FetchUsuarioConCarrito
import repositorios.FetchUsuarioConCarritoCompleto
import repositorios.RepoContenido
import repositorios.RepoEntrada
import repositorios.RepoFuncion
import repositorios.RepoLocator
import repositorios.RepoUsuario
import java.time.LocalDateTime
import java.time.Month

class TestPersistenciaUsuario {

	RepoContenido repoContenido
	RepoUsuario repoUsuarios
	RepoEntrada repoEntradas
	RepoFuncion repoFunciones
	Usuario aniston
	Usuario deNiro
	Pelicula matrix
	Pelicula matrix2
	Pelicula matrix3
	Saga sagaMatrix
	Pelicula pulpFiction
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

		repoUsuarios.create(aniston)
		repoUsuarios.create(deNiro)
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

		repoContenido.create(matrix)
		repoContenido.create(matrix2)
		repoContenido.create(matrix3)
		repoContenido.create(sagaMatrix)
		repoContenido.create(pulpFiction)
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
		val anistonActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConAmigos)
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
		repoContenido.delete(sagaMatrix)
		repoContenido.delete(matrix)
		repoContenido.delete(matrix2)
		repoContenido.delete(matrix3)
		repoContenido.delete(pulpFiction)
	}
}
