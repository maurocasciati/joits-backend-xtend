package vistas

import domain.Usuario
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import viewModels.PanelControlViewModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class PanelControl extends Ventana<PanelControlViewModel> {

	new(WindowOwner owner, Long idUsuarioLogueado) {
		super(owner, new PanelControlViewModel(idUsuarioLogueado))
	}

	override protected addActions(Panel actionsPanel) {
	}

	override createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		new GroupPanel(mainPanel) => [
			layout = new HorizontalLayout
			title = "Datos del usuario:"

			new Panel(it) => [
				layout = new VerticalLayout
				agregarLineaValor("Usuario", "nombreApellidoUsuario")
				agregarLineaCampoNumerico("Edad", "edadUsuario")
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
						actualizarVista("saldoUsuario")
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
						modelObject.traerUsuarioLogueado
						actualizarVista("listaDeAmigos")
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
					height = 130
					bindItems(new ObservableProperty("amigoSeleccionado.historial"))
				]
				new Panel(it) => [
					layout = new HorizontalLayout
					new Button(it) => [
						caption = "Volver"
						onClick[close]
					]
					new Button(it) => [
						enabled <=> "puedeGuardar"
						caption = "Aceptar"
						onClick[
							modelObject.actualizar
							close
						]
					]
				]
			]
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
		val tablaUsuarios = new Table<Usuario>(panel, typeof(Usuario)) => [
			items <=> listado
			value <=> valorSeleccionado
			numberVisibleRows = filas
		]
		crearColumnaParaTabla(tablaUsuarios, "Nombre", "nombre", 100)
		crearColumnaParaTabla(tablaUsuarios, "Apellido", "apellido", 100)
	}

}
