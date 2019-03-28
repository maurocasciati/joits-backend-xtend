package vistas

import domain.Usuario
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import viewModels.LoginViewModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class Login extends Dialog<LoginViewModel> {

	new(WindowOwner parent) {
		super(parent, new LoginViewModel)
	}

	override addActions(Panel actionsPanel) {

		new GroupPanel(actionsPanel) => [
			title = ""
			layout = new HorizontalLayout
			new Button(it) => [
				caption = "Aceptar"
				onClick([|modelObject.aceptar(this)])
				enabled <=> "completoCampos"
				setAsDefault
				width = 110
			]
			new Button(it) => [
				caption = "Cancelar"
				onClick([|close])
				width = 110
			]
		]
	}

	override createFormPanel(Panel mainPanel) {
		this.title = "Joits - Login"

		new Panel(mainPanel) => [
			layout = new VerticalLayout
			new GroupPanel(it) => [
				title = ""
				agregarLineaTextbox("Usuario", "username")
				agregarLineaPassword("Password", "password")
			]
		]
	}

	def void agregarLineaTextbox(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			alignCenter
			width = 80
		]
		new TextBox(valorPanel) => [
			value <=> valor
			width = 120
		]
	}

	def void agregarLineaPassword(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			alignCenter
			width = 80
		]
		new PasswordField(valorPanel) => [
			value <=> valor
			width = 120
		]
	}

	def agregarCampoUsuario(Panel panel) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new TextBox(valorPanel) => [
			value <=> "valorDeBusqueda"
			width = 400
			alignLeft
		]
	}

	def void irASeleccionarPelicula(Usuario usuarioLogueado) {
		new SeleccionPelicula(this, usuarioLogueado) => [
			open
		]
	}
}
