package vistas

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
import org.uqbar.arena.bindings.ObservableProperty
import domain.Contenido
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.commons.model.utils.ObservableUtils
import org.uqbar.arena.aop.windows.TransactionalDialog
import viewModels.BuscarAmigosViewModel

class BuscarAmigos extends TransactionalDialog<BuscarAmigosViewModel> {

	new(WindowOwner owner, Usuario usuarioLogueado) {
		super(owner, new BuscarAmigosViewModel)
		modelObject.usuarioLogueado = usuarioLogueado
	}

	override createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		new GroupPanel(mainPanel) => [
			layout = new HorizontalLayout
			title = "Buscar Persona"

			new Panel(it) => [
				layout = new VerticalLayout
				agregarLineaCuadroTexto("Nombre, Apellido o Username", "valorBuscado")

				new Button(it) => [
					caption = "Buscar"
					onClick[
						modelObject.buscarAmigos
						ObservableUtils.firePropertyChanged(this.modelObject, "listado")
					]
				]
			]
		]

		new GroupPanel(mainPanel) => [
			layout = new HorizontalLayout
			title = "Amigos"
			new Panel(it) => [
				width = 180
				new Table<Usuario>(it, Usuario) => [
					items <=> "listado"
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
