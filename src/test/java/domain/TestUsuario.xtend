package domain

import java.math.BigDecimal
import java.util.ArrayList
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorios.RepoContenido
import repositorios.RepoEntrada
import repositorios.RepoFuncion
import repositorios.RepoLocator
import repositorios.RepoUsuario
import org.junit.After
import java.util.HashSet

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

	@Before
	def void init() {
		inicializarRepos
		crearContenido
		inicializarUsuarios
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
			saldo = new BigDecimal(330)
			contrasenia = "jen123"
		]

		deNiro = new Usuario => [
			nombre = "Robert"
			apellido = "De Niro"
			username = "robertito"
			edad = 75
			saldo = new BigDecimal(964)
			contrasenia = "roberto"
		]

		scorsese = new Usuario => [
			nombre = "Martin"
			apellido = "Scorsese"
			username = "MartyBoy"
			edad = 76
			saldo = new BigDecimal(167)
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

	@Test
	def seCreoElUsuarioAniston() {
		Assert.assertEquals(repoUsuarios.searchById(aniston.id), aniston)
	}

	@Test
	def anistonAgregaADeNiro() {
		aniston.agregarAmigo(deNiro)
		repoUsuarios.update(aniston)
		val anistonActualizada = repoUsuarios.searchById(aniston.id)
		Assert.assertTrue(anistonActualizada.listaDeAmigos.contains(deNiro))
	}

	@After
	def void end() {
		repoUsuarios.delete(aniston)
		repoUsuarios.delete(deNiro)
		repoUsuarios.delete(scorsese)
	}
}
