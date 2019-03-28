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
import org.uqbar.arena.widgets.List
import org.uqbar.arena.bindings.ObservableProperty
import domain.Contenido
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.commons.model.utils.ObservableUtils
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.NumericField

class PanelControl extends TransactionalDialog<PanelControlViewModel> {

	new(WindowOwner owner, Usuario usuarioLogueado) {
		super(owner, new PanelControlViewModel)
		modelObject.usuarioLogueado = usuarioLogueado
	}

	override createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		new GroupPanel(mainPanel) => [
			layout = new HorizontalLayout
			title = "Datos del usuario:"

			new Panel(it) => [
				layout = new VerticalLayout
				agregarLineaValor("Usuario", "nombreApellidoUsuario")
				agregarLineaCampoNumerico("Edad", "usuarioLogueado.edad")
			]
			new Panel(it) => [
				layout = new VerticalLayout
				agregarLineaValor("Saldo", "saldoUsuario")
				agregarLineaCampoNumerico("Cargar Saldo", "saldoParaCargar")

				new Button(it) => [
					caption = "Cargar"
					enabled <=> "pusoSaldo"
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
				agregarTablaUsuarios("listaDeAmigos", "amigoSeleccionado", 8)
				new Button(it) => [
					caption = "Buscar Amigos"
					onClick[
						new BuscarAmigos(this, modelObject.usuarioLogueado).open
						ObservableUtils.firePropertyChanged(this.modelObject, "listaDeAmigos")
					]
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

	def void agregarLineaCampoNumerico(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new NumericField(valorPanel) => [
			value <=> valor
			width = 50
			alignLeft
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

}
