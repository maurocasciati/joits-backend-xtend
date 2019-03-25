package application

import domain.Contenido
import domain.Funcion
import domain.Pelicula
import domain.Saga
import domain.Usuario
import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.Month
import java.util.ArrayList
import java.util.concurrent.ThreadLocalRandom
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import repositorios.RepoContenido
import repositorios.RepoLocator
import repositorios.RepoUsuario
import domain.Entrada

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
			nivelClasico = 200
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
			username = "c"
			edad = 45
			saldo = new BigDecimal(2020)
			contrasenia = "c"
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
		cacho.listaDeAmigos = #[deNiro, scorsese, messi, aniston]
		repoUsuarios.create(aniston)
		repoUsuarios.create(cacho)
		repoUsuarios.create(deNiro)
		repoUsuarios.create(messi)
		repoUsuarios.create(scorsese)
	}

	def crearFunciones() {

		agregarFuncionesRandom(matrix, 12)
		agregarFuncionesRandom(pulpFiction, 6)
		agregarFuncionesRandom(duroDeMatar, 9)
		agregarFuncionesRandom(elDiaDeLaMarmota, 5)
		agregarFuncionesRandom(nueveReinas, 7)
		agregarFuncionesRandom(duroDeMatar, 6)
		agregarFuncionesRandom(redSocial, 10)
		agregarFuncionesRandom(warGames, 5)
		agregarFuncionesRandom(losBañeros4, 9)
		agregarFuncionesRandom(volverAlFuturoI, 12)
		agregarFuncionesRandom(volverAlFuturoII, 7)
		agregarFuncionesRandom(volverAlFuturoIII, 11)
		agregarFuncionesRandom(volverAlFuturo, 4)

		deNiro.carrito.addAll(new Entrada(matrix.funciones.get(0)), new Entrada(duroDeMatar.funciones.get(2)))

	}

	def agregarFuncionesRandom(Contenido contenido, int cantidad) {

		var fecha = LocalDateTime.of(2019, Month.APRIL, 29, 18, 00, 40);
		var i = 0
		var String[] cines = #["Hoyts Unicenter", "ShowCase", "Hoyts Dot", "ShowCase", "Cinemark Caballito",
			"Bama Cine Arte", "Multiplex Belgrano", "Cine Lorca", "Cinemark Palermo", "Hoyts Abasto",
			"Village Cines Recoleta", "Atlas Flores", "Cinemark", "Cine Teatro Ocean", "Arte Multiplex",
			"Village Recoleta", "Showcase", "Village Cines Caballito", "Atlas", "Sala Leopoldo Lugones",
			"Hoyts Unicenter", "Multicenter", "Complejo Alejandro Dini", "Cine Viotti", "Lo de Casciati", "Helios",
			"Cine Plaza", "Cinemark Solei"]

		while (i < cantidad) {
			var int index = ThreadLocalRandom.current().nextInt(0, cines.size);
			var int randomNum = ThreadLocalRandom.current().nextInt(-10, 10 + 1);
			var int randomNum2 = ThreadLocalRandom.current().nextInt(-10, 10 + 1);
			contenido.funciones.add(
				new Funcion(fecha.plusDays(randomNum).plusHours(randomNum2), cines.get(index), contenido))
			i++
		}
	}
}
