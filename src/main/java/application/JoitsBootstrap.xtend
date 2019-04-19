package application

import domain.Contenido
import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Saga
import domain.Usuario
import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.Month
import java.util.ArrayList
import java.util.concurrent.ThreadLocalRandom
import repositorios.RepoContenido
import repositorios.RepoEntrada
import repositorios.RepoLocator
import repositorios.RepoUsuario
import repositorios.RepoFuncion
import org.uqbar.arena.bootstrap.Bootstrap
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class JoitsBootstrap implements Bootstrap {

	RepoContenido repoContenido
	RepoUsuario repoUsuarios
	RepoEntrada repoEntradas
	RepoFuncion repoFunciones
	Usuario aniston
	Usuario scorsese
	Usuario deNiro
	Usuario cacho
	Usuario messi
	Usuario paulina
	Usuario cora
	Pelicula matrix
	Pelicula matrix2
	Pelicula matrix3
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
	Saga sagaMatrix

	new() {
		repoContenido = RepoLocator.repoContenido
		repoUsuarios = RepoLocator.repoUsuario
		repoEntradas = RepoLocator.repoEntrada
		repoFunciones = RepoLocator.repoFuncion
	}

	override run() {
		crearContenido
		crearUsuarios
		crearFunciones
		agregarEntradasAUsuarios
	}

	def crearContenido() {

		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999)
		matrix.trailerURL = "https://www.youtube.com/watch?v=BRuDS0wcnW8"
		matrix2 = new Pelicula("The Matrix: Reloaded", 7.2, "Ciencia Ficción", 2003)
		matrix2.trailerURL = "https://www.youtube.com/watch?v=kYzz0FSgpSU"
		matrix3 = new Pelicula("The Matrix: Revolution", 6.7, "Ciencia Ficción", 2003)
		matrix3.trailerURL = "https://www.youtube.com/watch?v=hMbexEPAOQI"
		pulpFiction = new Pelicula("Pulp Fiction", 8.9, "Drama", 1994)
		pulpFiction.trailerURL = "https://www.youtube.com/watch?v=DkgTIjkVrY8"
		elDiaDeLaMarmota = new Pelicula("El día de la marmota", 8.0, "Comedia", 1993)
		elDiaDeLaMarmota.imdbID = "tt0107048"
		elDiaDeLaMarmota.trailerURL = "https://www.youtube.com/watch?v=GncQtURdcE4"
		nueveReinas = new Pelicula("Nueve Reinas", 7.9, "Drama", 2000)
		nueveReinas.imdbID = "tt0247586"
		nueveReinas.trailerURL = "https://www.youtube.com/watch?v=Awu9WonTVB0"
		duroDeMatar = new Pelicula("Duro de matar", 8.2, "Acción", 1988)
		duroDeMatar.imdbID = "tt0095016"
		duroDeMatar.trailerURL = "https://www.youtube.com/watch?v=2TQ-pOvI6Xo"
		redSocial = new Pelicula("Red Social", 7.7, "Drama", 2010)
		redSocial.trailerURL = "https://www.youtube.com/watch?v=TQAGdBecBuk"
		warGames = new Pelicula("War Games", 8.7, "Ciencia Ficción", 1983)
		warGames.trailerURL = "https://www.youtube.com/watch?v=hbqMuvnx5MU"
		losBañeros4 = new Pelicula("Los Bañeros 4: Los Rompeolas", 1.4, "Comedia", 2014)
		losBañeros4.trailerURL = "https://www.youtube.com/watch?v=qyvyF_APR6A"
		volverAlFuturoI = new Pelicula("Volver al futuro I", 8.5, "Ciencia Ficción", 1985)
		volverAlFuturoI.trailerURL = "https://www.youtube.com/watch?v=suUZWVnmgqc"
		volverAlFuturoII = new Pelicula("Volver al futuro II", 7.8, "Ciencia Ficción", 1989)
		volverAlFuturoII.trailerURL = "https://www.youtube.com/watch?v=Bmr2fgaoSxs"
		volverAlFuturoIII = new Pelicula("Volver al futuro III", 7.4, "Ciencia Ficción", 1990)
		volverAlFuturoIII.trailerURL = "https://www.youtube.com/watch?v=W5TvFkM1Uyg"

		volverAlFuturo = new Saga => [
			titulo = "Saga Volver al futuro"
			puntaje = 7.9
			genero = "Ciencia Ficción"
			anioRecopilacion = 2012
			nivelClasico = 200
			peliculas = new ArrayList<Pelicula>
			peliculas.addAll(volverAlFuturoI, volverAlFuturoII, volverAlFuturoIII)
			trailerURL = "https://www.youtube.com/watch?v=Ktx1uv-F8EU"
		]
		sagaMatrix = new Saga => [
			titulo = "Saga Matrix"
			puntaje = 7.5
			genero = "Ciencia Ficción"
			anioRecopilacion = 2007
			nivelClasico = 120
			peliculas = new ArrayList<Pelicula>
			peliculas.addAll(matrix, matrix2, matrix3)
			trailerURL = "https://www.youtube.com/watch?v=ZOxRqas9vWk"
		]

		repoContenido.create(matrix)
		repoContenido.create(matrix2)
		repoContenido.create(matrix3)
		repoContenido.create(sagaMatrix)
		repoContenido.create(duroDeMatar)
		repoContenido.create(nueveReinas)
		repoContenido.create(elDiaDeLaMarmota)
		repoContenido.create(pulpFiction)
		repoContenido.create(redSocial)
		repoContenido.create(volverAlFuturoI)
		repoContenido.create(volverAlFuturoII)
		repoContenido.create(volverAlFuturoIII)
		repoContenido.create(volverAlFuturo)
		repoContenido.create(warGames)
		repoContenido.create(losBañeros4)
	}

	def crearUsuarios() {

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

		cacho = new Usuario => [
			nombre = "Cacho"
			apellido = "Gomez"
			username = "c"
			edad = 45
			saldo = new BigDecimal("2020")
			contrasenia = "c"
		]

		messi = new Usuario => [
			nombre = "Lionel"
			apellido = "Messi"
			username = "leomessi"
			edad = 31
			saldo = new BigDecimal("1312")
			contrasenia = "L10forever"
		]

		paulina = new Usuario => [
			nombre = "Paulina"
			apellido = "Paulina"
			username = "pau"
			edad = 28
			saldo = new BigDecimal("150")
			contrasenia = "pau"
		]

		cora = new Usuario => [
			nombre = "Coralina"
			apellido = "Rodriguez"
			username = "cora"
			edad = 28
			saldo = new BigDecimal("150")
			contrasenia = "cora"
		]

		repoUsuarios.create(aniston)
		repoUsuarios.create(cacho)
		repoUsuarios.create(deNiro)
		repoUsuarios.create(messi)
		repoUsuarios.create(scorsese)
		repoUsuarios.create(cora)
		repoUsuarios.create(paulina)

		aniston.listaDeAmigos.addAll(deNiro, scorsese, messi)
		cacho.listaDeAmigos.addAll(deNiro, aniston)
		cora.listaDeAmigos.addAll(deNiro, aniston, paulina, messi)
		paulina.listaDeAmigos.addAll(cora, scorsese, messi)

		repoUsuarios.update(aniston)
		repoUsuarios.update(cacho)
		repoUsuarios.update(cora)
		repoUsuarios.update(paulina)
	}

	def crearFunciones() {

		agregarFuncionesRandom(matrix, 12)
		agregarFuncionesRandom(matrix2, 8)
		agregarFuncionesRandom(matrix3, 6)
		agregarFuncionesRandom(sagaMatrix, 7)
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
	}

	def agregarFuncionesRandom(Contenido contenido, int cantidad) {

		var fecha = LocalDateTime.of(2019, Month.APRIL, 29, 18, 00, 00);
		var i = new Long(0)
		var String[] cines = #["Hoyts Unicenter", "ShowCase", "Hoyts Dot", "ShowCase", "Cinemark Caballito",
			"Bama Cine Arte", "Multiplex Belgrano", "Cine Lorca", "Cinemark Palermo", "Hoyts Abasto",
			"Village Cines Recoleta", "Atlas Flores", "Cinemark", "Cine Teatro Ocean", "Arte Multiplex",
			"Village Recoleta", "Showcase", "Village Cines Caballito", "Atlas", "Sala Leopoldo Lugones",
			"Hoyts Unicenter", "Multicenter", "Complejo Alejandro Dini", "Cine Viotti", "Lo de Casciati", "Helios",
			"Cine Plaza", "Cinemark Solei"]
		var minutos = #[0, 10, 15, 20, 25, 30, 35, 40, 45, 50]

		while (i < cantidad) {
			var int index = ThreadLocalRandom.current().nextInt(0, cines.size);
			var int diasRandom = ThreadLocalRandom.current().nextInt(-10, 10 + 1);
			var int horasRandom = ThreadLocalRandom.current().nextInt(-10, 10 + 1);
			var int indexMinutos = ThreadLocalRandom.current().nextInt(0, minutos.size);

			var funcion = new Funcion(
				fecha.plusDays(diasRandom).plusHours(horasRandom).plusMinutes(minutos.get(indexMinutos)),
				cines.get(index))
			repoFunciones.create(funcion)
			contenido.funciones.add(funcion)
			repoContenido.update(contenido)
			i++
		}
	}

	def agregarEntradasAUsuarios() {
		var entrada = new Entrada(volverAlFuturoIII, volverAlFuturoIII.funciones.get(0))
		var entrada2 = new Entrada(warGames, warGames.funciones.get(2))
		var entrada3 = new Entrada(losBañeros4, losBañeros4.funciones.get(2))
		var entrada4 = new Entrada(elDiaDeLaMarmota, elDiaDeLaMarmota.funciones.get(0))
		var entrada5 = new Entrada(matrix, matrix.funciones.get(1))
		var entrada6 = new Entrada(volverAlFuturoI, volverAlFuturoI.funciones.get(0))
		var entrada7 = new Entrada(redSocial, redSocial.funciones.get(1))
		var entrada8 = new Entrada(losBañeros4, losBañeros4.funciones.get(2))
		var entrada9 = new Entrada(volverAlFuturoII, volverAlFuturoII.funciones.get(2))
		var entrada10 = new Entrada(duroDeMatar, duroDeMatar.funciones.get(1))
		var entrada11 = new Entrada(warGames, warGames.funciones.get(1))
		var entrada12 = new Entrada(elDiaDeLaMarmota, elDiaDeLaMarmota.funciones.get(1))
		var entrada13 = new Entrada(duroDeMatar, duroDeMatar.funciones.get(0))
		var entrada14 = new Entrada(volverAlFuturoII, volverAlFuturoII.funciones.get(2))
		var entrada15 = new Entrada(pulpFiction, pulpFiction.funciones.get(2))
		var entrada16 = new Entrada(volverAlFuturo, volverAlFuturo.funciones.get(0))
		var entrada17 = new Entrada(redSocial, redSocial.funciones.get(1))
		val entrada18 = new Entrada(volverAlFuturoI, volverAlFuturoI.funciones.get(1))
		val entrada19 = new Entrada(pulpFiction, pulpFiction.funciones.get(0))
		val entrada20 = new Entrada(volverAlFuturoI, volverAlFuturoI.funciones.get(1))
		val entrada21 = new Entrada(pulpFiction, pulpFiction.funciones.get(0))

		repoEntradas.create(entrada)
		repoEntradas.create(entrada2)
		repoEntradas.create(entrada3)
		repoEntradas.create(entrada4)
		repoEntradas.create(entrada5)
		repoEntradas.create(entrada6)
		repoEntradas.create(entrada7)
		repoEntradas.create(entrada8)
		repoEntradas.create(entrada9)
		repoEntradas.create(entrada10)
		repoEntradas.create(entrada11)
		repoEntradas.create(entrada12)
		repoEntradas.create(entrada13)
		repoEntradas.create(entrada14)
		repoEntradas.create(entrada15)
		repoEntradas.create(entrada16)
		repoEntradas.create(entrada17)
		repoEntradas.create(entrada18)
		repoEntradas.create(entrada19)
		repoEntradas.create(entrada20)
		repoEntradas.create(entrada21)

		aniston.entradas.addAll(entrada, entrada2, entrada3)
		deNiro.entradas.addAll(entrada4, entrada5)
		cacho.entradas.addAll(entrada6, entrada7)
		cacho.carrito.addAll(entrada8, entrada18, entrada19)
		messi.entradas.addAll(entrada9, entrada10, entrada11, entrada12)
		scorsese.entradas.addAll(entrada13, entrada14, entrada15, entrada16, entrada17)

		repoUsuarios.update(aniston)
		repoUsuarios.update(deNiro)
		repoUsuarios.update(cacho)
		repoUsuarios.update(messi)
		repoUsuarios.update(scorsese)
		repoUsuarios.update(paulina)
		repoUsuarios.update(cora)
	}

	override isPending() {
		RepoLocator.repoUsuario.searchByExample(new Usuario).isEmpty
	}

}
