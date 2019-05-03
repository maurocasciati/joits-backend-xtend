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
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import repositorios.RepoContenido
import repositorios.RepoLocator
import repositorios.RepoUsuario

@Accessors
class JoitsBootstrap extends CollectionBasedBootstrap {

	RepoContenido repoContenido
	RepoUsuario repoUsuarios
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
	}

	override run() {
		if (RepoLocator.repoUsuario.searchByExample(new Usuario).isEmpty) {
			crearContenido
			crearUsuarios
			crearFunciones
			agregarEntradasAUsuarios
		}
	}

	def crearContenido() {

		matrix = new Pelicula("The Matrix", 8.7, "Ciencia Ficción", 1999, "603")
		matrix2 = new Pelicula("The Matrix: Reloaded", 7.2, "Ciencia Ficción", 2003, "604")
		matrix3 = new Pelicula("The Matrix: Revolution", 6.7, "Ciencia Ficción", 2003, "605")
		pulpFiction = new Pelicula("Pulp Fiction", 8.9, "Drama", 1994, "680")
		elDiaDeLaMarmota = new Pelicula("El día de la marmota", 8.0, "Comedia", 1993, "137")
		nueveReinas = new Pelicula("Nueve Reinas", 7.9, "Drama", 2000, "18079")
		duroDeMatar = new Pelicula("Duro de matar", 8.2, "Acción", 1988, "562")
		redSocial = new Pelicula("Red Social", 7.7, "Drama", 2010, "37799")
		warGames = new Pelicula("War Games", 8.7, "Ciencia Ficción", 1983, "14154")
		losBañeros4 = new Pelicula("Los Bañeros 4: Los Rompeolas", 1.4, "Comedia", 2014, "296945")
		volverAlFuturoI = new Pelicula("Volver al futuro I", 8.5, "Ciencia Ficción", 1985, "105")
		volverAlFuturoII = new Pelicula("Volver al futuro II", 7.8, "Ciencia Ficción", 1989, "165")
		volverAlFuturoIII = new Pelicula("Volver al futuro III", 7.4, "Ciencia Ficción", 1990, "196")

		volverAlFuturo = new Saga => [
			titulo = "Saga Volver al futuro"
			puntaje = 7.9
			genero = "Ciencia Ficción"
			anioRecopilacion = 2012
			nivelClasico = 200
			peliculas = new ArrayList<Pelicula>
			peliculas.addAll(volverAlFuturoI, volverAlFuturoII, volverAlFuturoIII)
			apiID = "105"
		]
		sagaMatrix = new Saga => [
			titulo = "Saga Matrix"
			puntaje = 7.5
			genero = "Ciencia Ficción"
			anioRecopilacion = 2007
			nivelClasico = 120
			peliculas = new ArrayList<Pelicula>
			peliculas.addAll(matrix, matrix2, matrix3)
			apiID = "603"
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
			imagenURL = "https://ep01.epimg.net/elpais/imagenes/2019/02/07/gente/1549557293_732656_1549639628_noticia_normal.jpg"
			saldo = new BigDecimal("330")
			setPasswordHash = "3FBDD18C7FBF4323800765BEABE2EFD37FC1233B0E18AD8F271AC76B7517E304" // jen123
		]

		deNiro = new Usuario => [
			nombre = "Robert"
			apellido = "De Niro"
			username = "robertito"
			edad = 75
			imagenURL = "https://m.media-amazon.com/images/M/MV5BMjAwNDU3MzcyOV5BMl5BanBnXkFtZTcwMjc0MTIxMw@@._V1_UY317_CR13,0,214,317_AL_.jpg"
			saldo = new BigDecimal("964")
			setPasswordHash = "72534C4A93DDC043FE3229ED46B1D526C4CCC747FEBDCD0F284F7F6057A37858" // roberto
		]

		scorsese = new Usuario => [
			nombre = "Martin"
			apellido = "Scorsese"
			username = "MartyBoy"
			edad = 76
			imagenURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Martin_Scorsese_Berlinale_2010_%28cropped%29.jpg/220px-Martin_Scorsese_Berlinale_2010_%28cropped%29.jpg"
			saldo = new BigDecimal("167")
			setPasswordHash = "94F806C643110DD37C28848E4C825B098ECEAB5B76B1FF0D9708D1AF60EC8932" // Ms2000
		]

		cacho = new Usuario => [
			nombre = "Cacho"
			apellido = "Gomez"
			username = "c"
			edad = 45
			imagenURL = "http://www.javiercacho.com/uploads/1/0/1/5/10159943/6508932.jpg?250"
			saldo = new BigDecimal("2020")
			setPasswordHash = "2E7D2C03A9507AE265ECF5B5356885A53393A2029D241394997265A1A25AEFC6" // c
		]

		messi = new Usuario => [
			nombre = "Lionel"
			apellido = "Messi"
			username = "leomessi"
			edad = 31
			imagenURL = "http://e00-co-marca.uecdn.es/claro/assets/multimedia/imagenes/2019/04/19/15556256166086.jpg"
			saldo = new BigDecimal("1312")
			setPasswordHash = "EFD8D201835C864623837BCE92A331433BDFA4FC488B2156A4357D42B1D5850D" // L10forever
		]

		paulina = new Usuario => [
			nombre = "Paulina"
			apellido = "Paulina"
			username = "pau"
			edad = 28
			imagenURL = "https://cdn-3.expansion.mx/dims4/default/09e4abb/2147483647/strip/true/crop/1500x2157+0+0/resize/800x1150!/quality/90/?url=https%3A%2F%2Fcdn-3.expansion.mx%2Fde%2Ffd%2Fde56442e4d1a93da91bce6fa3106%2Fpaulina-rubio.jpg"
			saldo = new BigDecimal("150")
			setPasswordHash = "470ADAA55FAB37A1A00DB983FCC022A1DBB13FC7361937F36CDC5F14DE19F6CE" // pau
		]

		cora = new Usuario => [
			nombre = "Coralina"
			apellido = "Rodriguez"
			username = "cora"
			edad = 28
			imagenURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Cora_logo.svg/1200px-Cora_logo.svg.png"
			saldo = new BigDecimal("150")
			setPasswordHash = "B8D8A9B672985B1DF0C1C580E2981200646F9120945B31F5407722BDA0E1E62A" // cora
		]

		repoUsuarios.create(aniston)
		repoUsuarios.create(cacho)
		repoUsuarios.create(deNiro)
		repoUsuarios.create(messi)
		repoUsuarios.create(scorsese)
		repoUsuarios.create(cora)
		repoUsuarios.create(paulina)

		cacho.listaDeAmigos.addAll(deNiro, aniston)
		repoUsuarios.update(cacho)
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
		var entrada9 = new Entrada(volverAlFuturoII, volverAlFuturoII.funciones.get(2))
		var entrada10 = new Entrada(duroDeMatar, duroDeMatar.funciones.get(1))
		var entrada11 = new Entrada(warGames, warGames.funciones.get(1))
		var entrada12 = new Entrada(elDiaDeLaMarmota, elDiaDeLaMarmota.funciones.get(1))
		var entrada13 = new Entrada(duroDeMatar, duroDeMatar.funciones.get(0))
		var entrada14 = new Entrada(volverAlFuturoII, volverAlFuturoII.funciones.get(2))
		var entrada15 = new Entrada(pulpFiction, pulpFiction.funciones.get(2))
		var entrada16 = new Entrada(volverAlFuturo, volverAlFuturo.funciones.get(0))
		var entrada17 = new Entrada(redSocial, redSocial.funciones.get(1))

		aniston.entradas.addAll(entrada, entrada2, entrada3)
		deNiro.entradas.addAll(entrada4, entrada5)
		cacho.entradas.addAll(entrada6, entrada7)
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
}
