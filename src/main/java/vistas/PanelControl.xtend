package vistas

import org.uqbar.arena.windows.Window
import viewModels.PanelControlViewModel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.layout.VerticalLayout
import domain.Usuario
import org.uqbar.arena.widgets.List
import org.uqbar.arena.bindings.ObservableProperty
import domain.Contenido
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.commons.model.utils.ObservableUtils

class PanelControl extends Window<PanelControlViewModel> {

	new(WindowOwner owner, Usuario usuarioLogueado) {
		super(owner, new PanelControlViewModel)
		modelObject.usuarioLogueado = usuarioLogueado
	}

	override createContents(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		new GroupPanel(mainPanel) => [
			layout = new HorizontalLayout
			title = "Datos del usuario:"

			new Panel(it) => [
				layout = new VerticalLayout
				agregarLineaValor("Usuario", "nombreApellidoUsuario")
				agregarLineaCuadroTexto("Edad", "usuarioLogueado.edad")
			]
			new Panel(it) => [
				layout = new VerticalLayout
				agregarLineaValor("Saldo", "saldoUsuario")
				agregarLineaCuadroTexto("Cargar Saldo", "saldoParaCargar")

				new Button(it) => [
					caption = "Cargar"
					onClick[
						modelObject.cargarSaldo
						ObservableUtils.firePropertyChanged(this.modelObject, "saldoUsuario")
					]
				]
			]
		]

		new GroupPanel(mainPanel) => [
			layout = new HorizontalLayout
			title = "Amigos:"
			new Panel(it) => [
				width = 180
				new Table<Usuario>(it, Usuario) => [
					items <=> "usuarioLogueado.listaDeAmigos"
					value <=> "amigoSeleccionado"
					numberVisibleRows = 8
					new Column<Usuario>(it) => [
						title = "Nombre"
						fixedSize = 90
						bindContentsToProperty("nombre")
					]
					new Column<Usuario>(it) => [
						title = "Apellido"
						fixedSize = 90
						bindContentsToProperty("apellido")
					]
				]
				new Button(it) => [
					caption = "Buscar Amigos"
					onClick[modelObject.buscarAmigos]
				]
			]
			new Panel(it) => [
				width = 180
				layout = new VerticalLayout
				new Label(it) => [
					text = "Peliculas vistas: "
				]
				new List(it) => [
					width = 180
					height = 100
					val peli = bindItems(new ObservableProperty("amigoSeleccionado.historial"))
					peli.adaptWith(typeof(Contenido), "titulo")
				]
			]
		]
	}

	def void agregarLineaValor(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new Label(valorPanel) => [
			value <=> valor
			width = 120
			alignLeft
		]
	}

	def void agregarLineaCuadroTexto(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new TextBox(valorPanel) => [
			value <=> valor
			width = 50
			alignLeft
		]
	}

}
