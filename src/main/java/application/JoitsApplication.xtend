package application

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import vistas.Login

class JoitsApplication extends Application {

	new(JoitsBootstrap bootstrap) {
		super(bootstrap)
	}

	static def void main(String[] args) {
		new JoitsApplication(new JoitsBootstrap).start()
	}

	override protected Window<?> createMainWindow() {
		return new Login(this)
	}

}
