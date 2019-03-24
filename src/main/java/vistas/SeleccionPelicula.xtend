package vistas

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import viewModels.SeleccionPeliculaViewModel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import domain.Pelicula
import org.uqbar.arena.widgets.tables.Column

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.commons.model.utils.ObservableUtils
import domain.Funcion
import org.uqbar.arena.bindings.NotNullObservable

class SeleccionPelicula extends SimpleWindow<SeleccionPeliculaViewModel> {

	new(WindowOwner parent) {
		super(parent, new SeleccionPeliculaViewModel)
	}

	override addActions(Panel mainPanel) {
	}

	override createFormPanel(Panel mainPanel) {
		this.title = "Joits - Compra de Tickets"
		new Panel(mainPanel) => [
			layout = new VerticalLayout
			agregarBarraUsuario()
			new Panel(it) => [
				layout = new HorizontalLayout
				agregarPanelPeliculas()
				agregarPanelFunciones()
			]
			new Button(it) => [
				caption = "Agregar entrada al carrito"
				bindEnabled(new NotNullObservable("funcionSeleccionada"))
				onClick[
					this.modelObject.agregarAlCarrito()
				]
			]
			new Panel(it) => [
				layout = new HorizontalLayout
				agregarLineaValor("Items en carrito: ", "cantidadItemsCarrito")
				new Button(it) => [
					caption = "Finalizar la compra"
					onClick[
						//TODO: Agregar msj error cuando el carrito esta vacio, y bindear con vista finalizarCompra
					]
				]
				// TODO: Alinear boton a la derecha
				new Button(it) => [
					caption = "Panel de control"
					onClick[
						new PanelControl(this).open
					]
				]
			]
		]
	}

	def agregarBarraUsuario(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			agregarLineaValor("Usuario logueado:", "usuarioLogueado")
			// TODO: Alinear fecha a la derecha
			agregarLineaValor("Fecha: ", "fechaHoy")
		]
	}

	def void agregarLineaValor(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			alignLeft
		]
		new Label(valorPanel) => [
			value <=> valor
			alignLeft
		]
	}

	def agregarPanelPeliculas(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new GroupPanel(it) => [
				layout = new VerticalLayout
				title = "Buscador de Películas:"
				agregarBuscador()
				agregarTabla("resultadoBusqueda", 6)
			]
			new GroupPanel(it) => [
				layout = new VerticalLayout
				title = "Películas recomendadas:"
				agregarTabla("peliculasRecomendadas", 4)
			]
		]

	}

	def agregarBuscador(Panel panel) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new TextBox(valorPanel) => [
			value <=> "valorDeBusqueda"
			width = 400
			alignLeft
		]
		new Button(valorPanel) => [
			caption = "Buscar"
			onClick[ObservableUtils.firePropertyChanged(this.modelObject, "resultadoBusqueda")]
		]
	}

	def agregarTabla(Panel panel, String listado, Integer filas) {
		new Table<Pelicula>(panel, typeof(Pelicula)) => [
			items <=> listado
			value <=> "peliculaSeleccionada"
			numberVisibleRows = filas
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("titulo")
				fixedSize = 200
			]
			new Column(it) => [
				title = "Año"
				bindContentsToProperty("anio")
				fixedSize = 100
			]
			new Column(it) => [
				title = "Rating"
				bindContentsToProperty("puntaje")
				fixedSize = 50
			]
			new Column(it) => [
				title = "Género"
				bindContentsToProperty("genero")
				fixedSize = 100
			]
		]
	}

	def agregarPanelFunciones(Panel panel) {
		new GroupPanel(panel) => [
			layout = new VerticalLayout
			title = "Funciones:"
			agregarTablaFunciones()
			agregarLineaValor("Importe de la entrada seleccionada: ", "funcionSeleccionada.precio")
		]

	}

	def agregarTablaFunciones(Panel panel) {
		new Table<Funcion>(panel, typeof(Funcion)) => [
			items <=> "funciones"
			value <=> "funcionSeleccionada"
			numberVisibleRows = 13
			new Column(it) => [
				title = "Fecha"
				bindContentsToProperty("fecha")
				fixedSize = 100
			]
			new Column(it) => [
				title = "Hora"
				bindContentsToProperty("hora")
				fixedSize = 50
			]
			new Column(it) => [
				title = "Sala"
				bindContentsToProperty("nombreSala")
				fixedSize = 200
			]
		]
	}

}
