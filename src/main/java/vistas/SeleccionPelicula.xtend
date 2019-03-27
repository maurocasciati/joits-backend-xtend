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
import domain.Usuario
import org.uqbar.arena.layout.ColumnLayout

class SeleccionPelicula extends SimpleWindow<SeleccionPeliculaViewModel> {

	new(WindowOwner parent, Usuario usuarioLogueado) {
		super(parent, new SeleccionPeliculaViewModel)
		modelObject.usuarioLogueado = usuarioLogueado
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
		]
	}

	def agregarBarraUsuario(Panel panel) {
		new Panel(panel) => [
			layout = new ColumnLayout(3)
			agregarLineaValor("Usuario logueado:", "usuarioLogueado.username")
			agregarLineaValor("Fecha: ", "fechaHoy")
			new Button(it) => [
				width = 290
				caption = "Panel de control"
				onClick[
					new PanelControl(this, modelObject.usuarioLogueado).open
				]
			]
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
				agregarBuscador("Buscador: ","valorDeBusqueda","resultadoBusqueda")
				agregarTabla("resultadoBusqueda", 6)
			]
			new GroupPanel(it) => [
				layout = new VerticalLayout
				title = "Películas recomendadas:"
				agregarTabla("peliculasRecomendadas", 4)
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
			width=200
			alignLeft
		]
		new Button(valorPanel) => [
			caption = "Buscar"
			onClick[ObservableUtils.firePropertyChanged(this.modelObject, listaResultado)]
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
			new Panel(it) => [
				layout = new ColumnLayout(2)
				agregarLineaValor("Importe de la entrada: ", "funcionSeleccionada.precio")
				new Button(it) => [
					caption = "Agregar al carrito"
					bindEnabled(new NotNullObservable("funcionSeleccionada"))
					onClick[
						this.modelObject.agregarAlCarrito()
						ObservableUtils.firePropertyChanged(this.modelObject, "cantidadItemsCarrito")
					]
				]
			]
			agregarLineaValor("Items en carrito: ", "cantidadItemsCarrito")
			new Button(it) => [
				caption = "Finalizar la compra"
				bindEnabled(new NotNullObservable("usuarioLogueado.carrito"))
				onClick[
					new FinalizarCompra(this, modelObject.usuarioLogueado).open
					ObservableUtils.firePropertyChanged(modelObject, "cantidadItemsCarrito")
				]
			]
		]

	}

	def agregarTablaFunciones(Panel panel) {
		new Table<Funcion>(panel, typeof(Funcion)) => [
			items <=> "funciones"
			value <=> "funcionSeleccionada"
			numberVisibleRows = 10
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
