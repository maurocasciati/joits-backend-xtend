package application

import org.uqbar.xtrest.api.XTRest

class JoitsBackendService {
	def static void main(String[] args) {
		val instancia = new JoitsBootstrap()
		instancia.run
		XTRest.startInstance(9000, new UsuariosApiRest(), new ContenidoApiRest)
	}

}
