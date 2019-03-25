package vistas

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import viewModels.LoginViewModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.PasswordField
import domain.Usuario

class Login extends Dialog<LoginViewModel> {

	new(WindowOwner parent) {
		super(parent, new LoginViewModel)
	}

	override addActions(Panel actionsPanel) {

		crearLabel(actionsPanel, "", 0, 30)

		new Button(actionsPanel) => [
			caption = "Aceptar"
			width = 100
			onClick([|modelObject.aceptar(this)])
			enabled <=> "completoCampos"
			setAsDefault
		]

		crearLabel(actionsPanel, "", 0, 10)

		new Button(actionsPanel) => [
			caption = "Cancelar"
			width = 100
			onClick([|cancel])
		]
		crearLabel(actionsPanel, "", 0, 30)
	}

	override createFormPanel(Panel mainPanel) {
		this.title = "Joits - Login"

		crearLabel(mainPanel, "", 20, 100)
		val panelUsuario = new Panel(mainPanel)
		val panelPassword = new Panel(mainPanel)

		panelUsuario.layout = new HorizontalLayout
		panelPassword.layout = new HorizontalLayout

		crearLabel(panelUsuario, "Usuario", 40, 90)
		crearTextBox(panelUsuario, "username", 150)
		crearLabel(panelPassword, "Password", 20, 90)
		crearPasswordField(panelPassword, "password", 150)
		crearLabel(mainPanel, "", 30, 100)
	}

	def crearLabel(Panel panel, String texto, int _height, int _width) {
		new Label(panel) => [
			text = texto
			height = _height
			width = _width
		]
	}

	def crearLabelConBinding(Panel panel, String valor, int _height, int _width) {
		new Label(panel) => [
			value <=> valor
			height = _height
			width = _width
		]
	}

	def crearTextBox(Panel panel, String valor, int _width) {
		new TextBox(panel) => [
			value <=> valor
			width = _width
		]
	}

	def crearPasswordField(Panel panel, String valor, int _width) {
		new PasswordField(panel) => [
			value <=> valor
			width = _width
		]
	}

	def void irASeleccionarPelicula(Usuario usuarioLogueado) {
		new SeleccionPelicula(this) => [
			open
		]
	}
}
