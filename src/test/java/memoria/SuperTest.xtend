package memoria

import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Saga
import domain.Usuario
import java.math.BigDecimal
import java.time.LocalDateTime
import java.time.Month
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SuperTest {

	Usuario aniston
	Usuario deNiro
	Pelicula matrix
	Pelicula matrix2
	Pelicula matrix3
	Saga sagaMatrix
	Pelicula pulpFiction
	Funcion funcion
	Entrada entrada
	Funcion funcionMiercoles
	Funcion funcionSabado
	Funcion funcionRegular

	def void init() {
		crearContenido
		inicializarUsuarios
		crearFunciones
		crearEntradas
	}

	def crearFunciones() {
		funcionMiercoles = new Funcion(LocalDateTime.of(2019, Month.APRIL, 10, 18, 00, 00), "Cinemark Palermo")
		funcionSabado = new Funcion(LocalDateTime.of(2019, Month.APRIL, 20, 12, 30, 00), "Hoyts Unicenter")
		funcionRegular = new Funcion(LocalDateTime.of(2019, Month.APRIL, 15, 17, 15, 00), "Cine Gaumont")
	}

	def crearEntradas() {
		entrada = new Entrada => [
			contenido = matrix
		]
		entrada.funcion = funcionMiercoles
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

	}

}
