package vistas

import domain.Usuario
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.model.utils.ObservableUtils
import viewModels.BuscarAmigosViewModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.bindings.NotNullObservable

class BuscarAmigos extends TransactionalDialog<BuscarAmigosViewModel> {

	new(WindowOwner owner, Usuario usuarioLogueado) {
		super(owner, new BuscarAmigosViewModel)
		modelObject.usuarioLogueado = usuarioLogueado
	}
	
	override addActions(Panel actionsPanel) {
	}

	override createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		new GroupPanel(mainPanel) => [
			layout = new VerticalLayout
			title = "Buscar Persona"
			agregarBuscador("Buscar usuario: ", "valorBuscado", "resultados")
			new Panel(it) => [
				width = 200
				agregarTablaUsuarios("resultados", "usuarioSeleccionado", 8)
			]
		]
		new GroupPanel(mainPanel) => [
			title = "Amigos sugeridos"
			new Panel(it) => [
				width = 200
				agregarTablaUsuarios("listadoSugeridos", "usuarioSeleccionado", 3)
			]
		]
		new Panel(mainPanel) => [
			layout = new HorizontalLayout
			new Button(it) => [
				caption = "Agregar a amigos"
				bindEnabled(new NotNullObservable("usuarioSeleccionado"))
				onClick[
					modelObject.agregarAmigo
				]
				width = 100
			]
			new Button(it) => [
				caption = "Volver"
				onClick[
					close
				]
				width = 100
			]
		]
	}

	def agregarTablaUsuarios(Panel panel, String listado, String valorSeleccionado, Integer filas) {
		new Table<Usuario>(panel, typeof(Usuario)) => [
			items <=> listado
			value <=> valorSeleccionado
			numberVisibleRows = filas
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
				fixedSize = 100
			]
			new Column(it) => [
				title = "Apellido"
				bindContentsToProperty("apellido")
				fixedSize = 100
			]
		]
	}

	def agregarBuscador(Panel panel, String nombre, String valorBuscado, String listaResultado) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			alignLeft
		]
		new TextBox(valorPanel) => [
			value <=> valorBuscado
			alignLeft
		]
		new Button(valorPanel) => [
			caption = "Buscar"
			onClick[ObservableUtils.firePropertyChanged(this.modelObject, listaResultado)]
		]
	}

}
