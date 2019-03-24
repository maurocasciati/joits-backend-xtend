package repositorios

import domain.Usuario
import org.uqbar.commons.model.exceptions.UserException

class RepoUsuario extends Repositorio<Usuario> {

	static RepoUsuario instance

	private new() {
	}

	override create(Usuario object) {
//		object.validar // -> si tiene errores de validación, no puede sumar objecto al repo.
		super.create(object)
	}

	def getUsuario(String username, String password) {
		val Usuario usuario = pool.findFirst[object|object.username.contentEquals(username)]

		if (usuario === null) {
			throw new UserException("Nombre de usuario inexistente")
		}

		if (!usuario.contrasenia.contentEquals(password)) {
			throw new UserException("Contraseña incorrecta")
		}
		usuario
	}

	override updateRecord(Usuario object) {
		var objetoEncontrado = searchById(object.id)
//		object.validar
		updateFieldByField(objetoEncontrado, object)
	}

	protected def void updateFieldByField(Usuario encontrado, Usuario nuevoDato) {
		encontrado.nombre = nuevoDato.nombre
		encontrado.apellido = nuevoDato.apellido
		encontrado.edad = nuevoDato.edad
		encontrado.listaDeAmigos = nuevoDato.listaDeAmigos
		encontrado.saldo = nuevoDato.saldo
		encontrado.contrasenia = nuevoDato.contrasenia
		encontrado.entradas = nuevoDato.entradas
	}

	def static getInstance() {
		if (instance === null) {
			instance = new RepoUsuario
		}
		instance
	}

}
