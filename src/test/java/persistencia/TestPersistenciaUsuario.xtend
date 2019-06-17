package persistencia

import domain.Carrito
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
import repositorios.RepoContenido
import repositorios.RepoLocator
import repositorios.RepoUsuario
import domain.Item
import repositorios.RepoUsuariosNeo4j

class TestPersistenciaUsuario {

	RepoContenido repoContenido
	RepoUsuario repoUsuarios
	RepoUsuariosNeo4j repoUsuariosNeo4j
	Usuario aniston
	Usuario deNiro
	Pelicula matrix
	Item entrada
	Funcion funcion
	Carrito carrito

	@Before
	def void init() {
		inicializarRepos
		crearFunciones
		crearContenido
		inicializarUsuarios
		crearEntradas
		crearCarrito
	}

	def inicializarRepos() {
		repoUsuarios = RepoLocator.repoUsuario
		repoUsuariosNeo4j = RepoLocator.repoUsuarioNeo
		repoContenido = RepoLocator.repoContenido
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

		repoUsuariosNeo4j.crearUsuarios(#[aniston, deNiro])
		repoUsuarios.create(aniston)
		repoUsuarios.create(deNiro)
	}

	def crearContenido() {
		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999, "")
		matrix.funciones.add(funcion)
		repoContenido.create(matrix)
	}

	def crearFunciones() {
		funcion = new Funcion(LocalDateTime.of(2019, Month.DECEMBER, 22, 15, 00, 00), "Cinemark Palermo")
	}

	def crearEntradas() {
		entrada = new Item(matrix, funcion)
	}

	def crearCarrito() {
		carrito = new Carrito
		carrito.getItems.add(entrada)
	}

	@Test
	def seCreaUsuario() {
		Assert.assertEquals(repoUsuarios.searchById(aniston.id), aniston)
	}

	@Test
	def seEliminaUsuario() {
		repoUsuarios.delete(aniston)
		val anistonDB = repoUsuarios.searchById(aniston.id)
		Assert.assertEquals(null, anistonDB)
	}

	@Test
	def unUsuarioAgregaAUnAmigo() {
		var anistonConAmigos = repoUsuarios.getUsuarioConAmigos(aniston.id)
		anistonConAmigos.agregarAmigo(deNiro)
		repoUsuarios.update(anistonConAmigos)
		val anistonActualizada = repoUsuarios.getUsuarioConAmigosYEntradas(aniston.id)
		Assert.assertTrue(anistonActualizada.listaDeAmigos.contains(deNiro))
	}

	@Test
	def unUsuarioCargaSaldo() {
		val BigDecimal saldoAnterior = aniston.saldo
		aniston.cargarSaldo(50.7)
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id)
		Assert.assertTrue((saldoAnterior + new BigDecimal("50.7")).compareTo(anistonActualizada.saldo) == 0)
	}

	@Test
	def unUsuarioCambiaEdad() {
		aniston.edad = 45
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id)
		Assert.assertEquals(45, anistonActualizada.edad)
	}

	@Test
	def unUsuarioFinalizaCompra() {
		val saldoAnterior = aniston.saldo
		val totalCompra = new BigDecimal(carrito.totalCarrito.toString)
		aniston.finalizarCompra(carrito)
		repoUsuariosNeo4j.guardarUsuario(aniston)
		repoUsuarios.update(aniston)
		var anistonDB = repoUsuarios.getUsuarioConEntradas(aniston.id)
		Assert.assertTrue((saldoAnterior - totalCompra).compareTo(anistonDB.saldo) == 0)
	}

	@After
	def void end() {
		repoUsuariosNeo4j.eliminarUsuario(aniston)
		repoUsuariosNeo4j.eliminarUsuario(deNiro)
		repoContenido.delete(matrix)
		repoUsuarios.delete(aniston)
		repoUsuarios.delete(deNiro)
	}
}
