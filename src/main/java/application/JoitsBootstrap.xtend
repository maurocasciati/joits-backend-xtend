package application

import domain.Funcion
import domain.Pelicula
import domain.Saga
import domain.Usuario
import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.Month
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import repositorios.RepoContenido
import repositorios.RepoLocator
import repositorios.RepoUsuario
import java.util.ArrayList

class JoitsBootstrap extends CollectionBasedBootstrap {

	RepoContenido repoContenido
	RepoUsuario repoUsuarios
	Usuario aniston
	Usuario scorsese
	Usuario deNiro
	Usuario cacho
	Usuario messi
	Pelicula matrix
	Pelicula pulpFiction
	Pelicula elDiaDeLaMarmota
	Pelicula nueveReinas
	Pelicula duroDeMatar
	Pelicula redSocial
	Pelicula warGames
	Pelicula losBañeros4
	Pelicula volverAlFuturoI
	Pelicula volverAlFuturoII
	Pelicula volverAlFuturoIII
	Saga volverAlFuturo
	Funcion funcion1
	Funcion funcion2
	Funcion funcion3
	Funcion funcion4
	Funcion funcion5
	Funcion funcion6
	Funcion funcion7
	Funcion funcion8
	Funcion funcion9

	new() {
		repoContenido = RepoLocator.getRepoContenido
		repoUsuarios = RepoLocator.getRepoUsuario
	}

	override run() {
		crearContenido
		crearUsuarios
		crearFunciones
	}

	def crearContenido() {

		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999)
		pulpFiction = new Pelicula("Pulp Fiction", 8.9, "Drama", 1994)
		elDiaDeLaMarmota = new Pelicula("El día de la marmota", 8.0, "Comedia", 1993)
		nueveReinas = new Pelicula("Nueve Reinas", 7.9, "Drama", 2000)
		duroDeMatar = new Pelicula("Duro de matar", 8.2, "Acción", 1988)
		redSocial = new Pelicula("Red Social", 7.7, "Drama", 2010)
		warGames = new Pelicula("War Games", 8.7, "Ciencia Ficción", 1983)
		losBañeros4 = new Pelicula("Los Bañeros 4: Los Rompeolas", 1.4, "Comedia", 2014)
		volverAlFuturoI = new Pelicula("Volver al futuro I", 8.5, "Ciencia Ficción", 1985)
		volverAlFuturoII = new Pelicula("Volver al futuro II", 7.8, "Ciencia Ficción", 1989)
		volverAlFuturoIII = new Pelicula("Volver al futuro III", 7.4, "Ciencia Ficción", 1990)

		volverAlFuturo = new Saga => [
			titulo = "Saga Volver al futuro"
			puntaje = 7.9
			genero = "Ciencia Ficción"
			anioRecopilacion = 2012
			peliculas = new ArrayList<Pelicula>
			peliculas.addAll(volverAlFuturoI, volverAlFuturoII, volverAlFuturoIII)
		]

		repoContenido.create(matrix)
		repoContenido.create(duroDeMatar)
		repoContenido.create(nueveReinas)
		repoContenido.create(elDiaDeLaMarmota)
		repoContenido.create(pulpFiction)
		repoContenido.create(redSocial)
		repoContenido.create(volverAlFuturo)
		repoContenido.create(volverAlFuturoI)
		repoContenido.create(volverAlFuturoII)
		repoContenido.create(volverAlFuturoIII)
		repoContenido.create(warGames)
		repoContenido.create(losBañeros4)
	}

	def crearUsuarios() {

		aniston = new Usuario => [
			nombre = "Jennifer"
			apellido = "Aniston"
			edad = 50
			saldo = new BigDecimal(330)
			contrasenia = "jen123"
			historial = #[matrix, duroDeMatar]
		]

		deNiro = new Usuario => [
			nombre = "Robert"
			apellido = "De Niro"
			edad = 75
			saldo = new BigDecimal(964)
			contrasenia = "roberto"
			historial = #[redSocial, pulpFiction]
		]

		scorsese = new Usuario => [
			nombre = "Martin"
			apellido = "Scorsese"
			edad = 76
			saldo = new BigDecimal(167)
			contrasenia = "Ms2000"
			historial = #[warGames, volverAlFuturo]
		]

		cacho = new Usuario => [
			nombre = "Cacho"
			apellido = "Gomez"
			edad = 45
			saldo = new BigDecimal(2020)
			contrasenia = "bocateamo"
			historial = #[matrix, duroDeMatar]
		]

		messi = new Usuario => [
			nombre = "Lionel"
			apellido = "Messi"
			edad = 31
			saldo = new BigDecimal(1312)
			contrasenia = "L10forever"
			historial = #[matrix, duroDeMatar, redSocial, elDiaDeLaMarmota]
		]
		
		aniston.listaDeAmigos = #[deNiro, scorsese, messi]
		repoUsuarios.create(aniston)
		repoUsuarios.create(cacho)
		repoUsuarios.create(deNiro)
		repoUsuarios.create(messi)
		repoUsuarios.create(scorsese)
	}

	def crearFunciones() {

		var fecha = LocalDateTime.of(2019, Month.APRIL, 29, 18, 30, 40);
		var fecha2 = fecha.plusHours(-5)

		funcion1 = new Funcion(fecha, "Hoyts Unicenter")
		funcion2 = new Funcion(fecha.plusHours(1), "ShowCase")
		funcion3 = new Funcion(fecha.plusHours(2), "Multiplex Belgrano")
		funcion4 = new Funcion(fecha2, "Hoyts Abasto")
		funcion5 = new Funcion(fecha2.plusHours(1), "Cinemark")
		funcion6 = new Funcion(fecha2.plusHours(2), "Village Recoleta")
		funcion7 = new Funcion(fecha2.plusHours(3), "Atlas")
		funcion8 = new Funcion(fecha.plusHours(1), "Multicenter")
		funcion9 = new Funcion(fecha.plusDays(3), "Gaumont")

		matrix.funciones.addAll(funcion1, funcion2, funcion3)
		pulpFiction.funciones.addAll(funcion4, funcion5, funcion6)
		duroDeMatar.funciones.addAll(funcion7, funcion8, funcion9)
		nueveReinas.funciones.addAll(funcion1, funcion2, funcion3)
		elDiaDeLaMarmota.funciones.addAll(funcion4, funcion5, funcion6)
		redSocial.funciones.addAll(funcion7, funcion8, funcion9)
		warGames.funciones.addAll(funcion1, funcion2, funcion3)
		losBañeros4.funciones.addAll(funcion4, funcion5, funcion6)
		volverAlFuturo.funciones.addAll(funcion7, funcion8, funcion9)
	}

}
