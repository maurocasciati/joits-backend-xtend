package vistas

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import viewModels.LoginViewModel

class Login extends SimpleWindow<LoginViewModel> {

	new(WindowOwner parent) {
		super(parent, new LoginViewModel)
	}

	override addActions(Panel mainPanel) {
	}

	override createFormPanel(Panel mainPanel) {
		this.title = "Joits - Login"
	}
}
