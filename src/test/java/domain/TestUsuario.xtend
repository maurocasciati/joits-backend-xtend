package domain

import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.Month
import java.util.ArrayList
import java.util.concurrent.ThreadLocalRandom
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorios.RepoContenido
import repositorios.RepoEntrada
import repositorios.RepoFuncion
import repositorios.RepoLocator
import repositorios.RepoUsuario
import repositorios.FetchNothing
import repositorios.FetchUsuarioConAmigos
import repositorios.FetchUsuarioConCarrito
import repositorios.FetchUsuarioConCarritoCompleto

class TestUsuario {

	RepoContenido repoContenido
	RepoUsuario repoUsuarios
	RepoEntrada repoEntradas
	RepoFuncion repoFunciones
	Usuario aniston
	Usuario deNiro
	Usuario scorsese
	Pelicula matrix
	Pelicula matrix2
	Pelicula matrix3
	Pelicula pulpFiction
	Pelicula elDiaDeLaMarmota
	Pelicula losBañeros4
	Saga sagaMatrix
	Entrada entrada
	Entrada entrada2
	Entrada entrada3
	Funcion funcion
	Funcion funcion2
	Funcion funcion3

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

		scorsese = new Usuario => [
			nombre = "Martin"
			apellido = "Scorsese"
			username = "MartyBoy"
			edad = 76
			saldo = new BigDecimal("167")
			contrasenia = "Ms2000"
		]

		repoUsuarios.create(aniston)
		repoUsuarios.create(deNiro)
		repoUsuarios.create(scorsese)
	}

	def crearContenido() {

		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999)
		matrix2 = new Pelicula("The Matrix: Reloaded", 7.2, "Ciencia Ficción", 2003)
		matrix3 = new Pelicula("The Matrix: Revolution", 6.7, "Ciencia Ficción", 2003)
		pulpFiction = new Pelicula("Pulp Fiction", 8.9, "Drama", 1994)
		elDiaDeLaMarmota = new Pelicula("El día de la marmota", 8.0, "Comedia", 1993)
		losBañeros4 = new Pelicula("Los Bañeros 4: Los Rompeolas", 1.4, "Comedia", 2014)

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
		repoContenido.create(elDiaDeLaMarmota)
		repoContenido.create(pulpFiction)
		repoContenido.create(losBañeros4)
	}

	def crearFunciones() {
		funcion = new Funcion
		funcion2 = new Funcion
		funcion3 = new Funcion

		repoFunciones.create(funcion)
		repoFunciones.create(funcion2)
		repoFunciones.create(funcion3)
	}

	def crearEntradas() {
		entrada = new Entrada(matrix, funcion)
		entrada2 = new Entrada(elDiaDeLaMarmota, funcion2)
		entrada3 = new Entrada(pulpFiction, funcion3)

		repoEntradas.create(entrada)
		repoEntradas.create(entrada2)
		repoEntradas.create(entrada3)
	}

	@Test
	def seCreaUsuario() {
		Assert.assertEquals(repoUsuarios.searchById(aniston.id, new FetchNothing), aniston)
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
		val carritoAntes = aniston.carrito.length
		aniston.agregarAlCarrito(entrada)
		repoUsuarios.update(aniston)
		val anistonConCarritoActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConCarrito)
		Assert.assertEquals(carritoAntes + 1, anistonConCarritoActualizada.carrito.length)
//		Assert.assertTrue(anistonConCarritoActualizada.carrito.contains(entrada))
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
		val carritoAntes = aniston.carrito.length
		aniston.eliminarItem(entrada)
		repoUsuarios.update(aniston)
		val anistonConCarritoActualizada = repoUsuarios.searchById(aniston.id, new FetchUsuarioConCarrito)
		Assert.assertEquals(carritoAntes - 1, anistonConCarritoActualizada.carrito.length)
	}

	@After
	def void end() {
		repoUsuarios.delete(aniston)
		repoUsuarios.delete(deNiro)
		repoUsuarios.delete(scorsese)
		repoUsuarios.delete(aniston)
		repoUsuarios.delete(deNiro)
		repoUsuarios.delete(scorsese)
		repoEntradas.delete(entrada)
		repoEntradas.delete(entrada2)
		repoEntradas.delete(entrada3)
		repoFunciones.delete(funcion)
		repoFunciones.delete(funcion2)
		repoFunciones.delete(funcion3)
		repoContenido.delete(sagaMatrix)
		repoContenido.delete(matrix)
		repoContenido.delete(matrix2)
		repoContenido.delete(matrix3)
		repoContenido.delete(elDiaDeLaMarmota)
		repoContenido.delete(pulpFiction)
		repoContenido.delete(losBañeros4)
	}
}
