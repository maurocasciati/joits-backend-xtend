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
import domain.Contenido

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
			username = "rachel_g"
			edad = 50
			saldo = new BigDecimal(330)
			contrasenia = "jen123"
			historial = #[matrix, duroDeMatar]
		]

		deNiro = new Usuario => [
			nombre = "Robert"
			apellido = "De Niro"
			username = "robertito"
			edad = 75
			saldo = new BigDecimal(964)
			contrasenia = "roberto"
			historial = #[redSocial, pulpFiction]
		]

		scorsese = new Usuario => [
			nombre = "Martin"
			apellido = "Scorsese"
			username = "MartyBoy"
			edad = 76
			saldo = new BigDecimal(167)
			contrasenia = "Ms2000"
			historial = #[warGames, volverAlFuturo]
		]

		cacho = new Usuario => [
			nombre = "Cacho"
			apellido = "Gomez"
			username = "cachito27"
			edad = 45
			saldo = new BigDecimal(2020)
			contrasenia = "bocateamo"
			historial = #[matrix, duroDeMatar]
		]

		messi = new Usuario => [
			nombre = "Lionel"
			apellido = "Messi"
			username = "leomessi"
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

		var Funcion funcionMatrix = new Funcion(fecha, "Hoyts Unicenter", matrix)
		var Funcion funcionMatrix2 = new Funcion(fecha.plusDays(2).plusHours(1), "ShowCase", matrix)
		var Funcion funcionMatrix3 = new Funcion(funcionMatrix.fechaHora.plusHours(2), "Hoyts Dot", matrix)
		var Funcion funcionPulpFiction = new Funcion(fecha.plusDays(3).plusHours(1), "ShowCase", pulpFiction)
		var Funcion funcionPulpFiction2 = new Funcion(fecha.plusDays(4).plusHours(-4), "Cinemark Caballito",
			pulpFiction)
		var Funcion funcionPulpFiction3 = new Funcion(fecha.plusDays(7).plusHours(-3), "Bama Cine Arte", pulpFiction)
		var Funcion funcionElDiaDeLaMarmota = new Funcion(fecha.plusDays(5).plusHours(2), "Multiplex Belgrano",
			elDiaDeLaMarmota)
		var Funcion funcionElDiaDeLaMarmota2 = new Funcion(fecha.plusDays(3).plusHours(-3), "Cine Lorca",
			elDiaDeLaMarmota)
		var Funcion funcionElDiaDeLaMarmota3 = new Funcion(fecha.plusDays(1).plusHours(6), "Cinemark Palermo",
			elDiaDeLaMarmota)
		var Funcion funcionNueveReinas = new Funcion(fecha.plusDays(4).plusHours(4), "Hoyts Abasto", nueveReinas)
		var Funcion funcionNueveReinas2 = new Funcion(fecha.plusDays(2), "Village Cines Recoleta", nueveReinas)
		var Funcion funcionNueveReinas3 = new Funcion(fecha.plusDays(-4).plusHours(2), "Atlas Flores", nueveReinas)
		var Funcion funcionDuroDeMatar = new Funcion(fecha.plusDays(1).plusHours(8), "Cinemark", duroDeMatar)
		var Funcion funcionDuroDeMatar2 = new Funcion(fecha.plusDays(-3).plusHours(-5), "Cine Teatro Ocean",
			duroDeMatar)
		var Funcion funcionDuroDeMatar3 = new Funcion(fecha.plusDays(6), "Arte Multiplex", duroDeMatar)
		var Funcion funcionRedSocial = new Funcion(fecha.plusDays(2).plusHours(2), "Village Recoleta", redSocial)
		var Funcion funcionRedSocial2 = new Funcion(fecha.plusDays(-1).plusHours(-4), "Showcase", redSocial)
		var Funcion funcionRedSocial3 = new Funcion(fecha.plusDays(5), "Village Cines Caballito", redSocial)
		var Funcion funcionWarGames = new Funcion(fecha.plusDays(6).plusHours(3), "Atlas", warGames)
		var Funcion funcionWarGames2 = new Funcion(fecha.plusDays(3).plusHours(1), "Sala Leopoldo Lugones", warGames)
		var Funcion funcionWarGames3 = new Funcion(fecha.plusHours(1), "Hoyts Unicenter", warGames)
		var Funcion funcionLosBañeros4 = new Funcion(fecha.plusDays(7).plusHours(6), "Multicenter", losBañeros4)
		var Funcion funcionLosBañeros42 = new Funcion(fecha, "Multiplex Belgrano", losBañeros4)
		var Funcion funcionLosBañeros43 = new Funcion(fecha.plusDays(7).plusHours(6), "Cine Lorca", losBañeros4)
		var Funcion funcionVolverAlFuturo = new Funcion(fecha, "Gaumont", volverAlFuturo)
		var Funcion funcionVolverAlFuturo2 = new Funcion(fecha.plusDays(-4).plusHours(-2), "Cinemark Palermo",
			volverAlFuturo)
		var Funcion funcionVolverAlFuturo3 = new Funcion(fecha.plusDays(1).plusHours(4), "Village Recoleta",
			volverAlFuturo)
		var Funcion funcionVolverAlFuturo11 = new Funcion(fecha, "Atlas", volverAlFuturoI)
		var Funcion funcionVolverAlFuturo12 = new Funcion(fecha.plusDays(-1).plusHours(2), "Hoyts Abasto",
			volverAlFuturoI)
		var Funcion funcionVolverAlFuturo13 = new Funcion(fecha.plusDays(1).plusHours(4), "Village Recoleta",
			volverAlFuturoI)
		var Funcion funcionVolverAlFuturo21 = new Funcion(fecha.plusDays(2).plusHours(1), "Atlas Flores",
			volverAlFuturoII)
		var Funcion funcionVolverAlFuturo22 = new Funcion(fecha.plusDays(-4).plusHours(-2), "Cinemark Palermo",
			volverAlFuturoII)
		var Funcion funcionVolverAlFuturo23 = new Funcion(fecha.plusDays(3).plusHours(2), "Bama Cine Arte",
			volverAlFuturoII)
		var Funcion funcionVolverAlFuturo31 = new Funcion(fecha.plusDays(-5).plusHours(6), "Arte Multiplex",
			volverAlFuturoIII)
		var Funcion funcionVolverAlFuturo32 = new Funcion(fecha.plusDays(4).plusHours(8), "Sala Leopoldo Lugones",
			volverAlFuturoIII)
		var Funcion funcionVolverAlFuturo33 = new Funcion(fecha.plusDays(6).plusHours(5), "Village Cines Caballito",
			volverAlFuturoIII)

		matrix.funciones.addAll(funcionMatrix, funcionMatrix2, funcionMatrix3, copia(funcionPulpFiction, matrix),
			copia(funcionDuroDeMatar, matrix), copia(funcionNueveReinas, matrix))

		pulpFiction.funciones.addAll(funcionPulpFiction, funcionPulpFiction2, funcionPulpFiction3,
			copia(funcionMatrix2, pulpFiction), copia(funcionDuroDeMatar2, pulpFiction))

		duroDeMatar.funciones.addAll(funcionDuroDeMatar, funcionDuroDeMatar2, funcionDuroDeMatar3,
			copia(funcionPulpFiction3, duroDeMatar), copia(funcionMatrix3, duroDeMatar))

		nueveReinas.funciones.addAll(funcionNueveReinas, funcionNueveReinas2, funcionNueveReinas3,
			copia(funcionRedSocial, nueveReinas), copia(funcionWarGames, nueveReinas),
			copia(funcionLosBañeros4, nueveReinas))

		elDiaDeLaMarmota.funciones.addAll(funcionElDiaDeLaMarmota, funcionElDiaDeLaMarmota2, funcionElDiaDeLaMarmota3,
			copia(funcionRedSocial2, elDiaDeLaMarmota), copia(funcionWarGames2, elDiaDeLaMarmota),
			copia(funcionLosBañeros42, elDiaDeLaMarmota), copia(funcionVolverAlFuturo2, elDiaDeLaMarmota))

		redSocial.funciones.addAll(funcionRedSocial, funcionRedSocial2, funcionRedSocial3,
			copia(funcionWarGames3, redSocial), copia(funcionLosBañeros43, redSocial),
			copia(funcionVolverAlFuturo23, redSocial), copia(funcionVolverAlFuturo3, redSocial))

		warGames.funciones.addAll(funcionWarGames, funcionWarGames2, funcionWarGames3,
			copia(funcionVolverAlFuturo11, warGames), copia(funcionVolverAlFuturo21, warGames),
			copia(funcionVolverAlFuturo31, warGames))

		losBañeros4.funciones.addAll(funcionLosBañeros4, funcionLosBañeros42, funcionLosBañeros43,
			copia(funcionRedSocial2, losBañeros4), copia(funcionVolverAlFuturo12, losBañeros4))

		volverAlFuturo.funciones.addAll(funcionVolverAlFuturo, funcionVolverAlFuturo2, funcionVolverAlFuturo3,
			copia(funcionElDiaDeLaMarmota, volverAlFuturo), copia(funcionVolverAlFuturo13, volverAlFuturo),
			copia(funcionVolverAlFuturo23, volverAlFuturo))

		volverAlFuturoI.funciones.addAll(funcionVolverAlFuturo11, funcionVolverAlFuturo12, funcionVolverAlFuturo13,
			copia(funcionNueveReinas2, volverAlFuturoI), copia(funcionElDiaDeLaMarmota2, volverAlFuturoI),
			copia(funcionVolverAlFuturo32, volverAlFuturoI))

		volverAlFuturoII.funciones.addAll(funcionVolverAlFuturo21, funcionVolverAlFuturo22, funcionVolverAlFuturo23,
			copia(funcionElDiaDeLaMarmota3, volverAlFuturoII))

		volverAlFuturoIII.funciones.addAll(funcionVolverAlFuturo31, funcionVolverAlFuturo32, funcionVolverAlFuturo33)

	}

	def copia(Funcion funcion, Contenido contenido) {
		new Funcion(funcion.fechaHora.plusDays(1).plusHours(1), funcion.nombreSala, contenido)
	}

}
