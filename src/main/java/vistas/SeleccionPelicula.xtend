package vistas

import domain.Funcion
import domain.Pelicula
import domain.Usuario
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import viewModels.SeleccionPeliculaViewModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import domain.Contenido

class SeleccionPelicula extends Ventana<SeleccionPeliculaViewModel> {

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
					new PanelControl(this, modelObject.usuarioLogueado.id).open
				]
			]
		]
	}

	def agregarPanelPeliculas(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new GroupPanel(it) => [
				layout = new VerticalLayout
				title = "Buscador de Películas:"
				agregarBuscador("Buscador: ", "valorDeBusqueda", "resultadoBusqueda", 200)
				agregarTabla("resultadoBusqueda", 6)
			]
			new GroupPanel(it) => [
				layout = new VerticalLayout
				title = "Películas recomendadas:"
				agregarTabla("peliculasRecomendadas", 4)
			]
		]

	}

	def agregarTabla(Panel panel, String listado, Integer filas) {
		val tabla = new Table<Contenido>(panel, typeof(Contenido)) => [
			items <=> listado
			value <=> "peliculaSeleccionada"
			numberVisibleRows = filas
		]
		crearColumnaParaTabla(tabla, "Nombre", "titulo", 200)
		crearColumnaParaTabla(tabla, "Año", "anio", 100)
		crearColumnaParaTabla(tabla, "Rating", "puntaje", 50)
		crearColumnaParaTabla(tabla, "Género", "genero", 130)
	}

	def agregarPanelFunciones(Panel panel) {
		new GroupPanel(panel) => [
			layout = new VerticalLayout
			title = "Funciones:"
			agregarTablaFunciones()
			new Panel(it) => [
				layout = new ColumnLayout(2)
				agregarLineaValor("Importe de la entrada: ", "precioEntrada")
				new Button(it) => [
					caption = "Agregar al carrito"
					bindEnabled(new NotNullObservable("funcionSeleccionada"))
					onClick[
						this.modelObject.agregarAlCarrito()
						actualizarVista("cantidadItemsCarrito")
					]
				]
			]
			agregarLineaValor("Items en carrito: ", "cantidadItemsCarrito")
			new Button(it) => [
				caption = "Finalizar la compra"
				bindEnabled(new NotNullObservable("usuarioLogueado.carrito"))
				onClick[
					new FinalizarCompra(this, modelObject.usuarioLogueado.id).open
					modelObject.traerUsuarioLogueado
					actualizarVista("cantidadItemsCarrito")
				]
			]
		]

	}

	def agregarTablaFunciones(Panel panel) {
		val tablaFunciones = new Table<Funcion>(panel, typeof(Funcion)) => [
			items <=> "peliculaFromDB.funciones"
			value <=> "funcionSeleccionada"
			numberVisibleRows = 10
		]
		crearColumnaParaTabla(tablaFunciones, "Fecha", "fecha", 100)
		crearColumnaParaTabla(tablaFunciones, "Hora", "hora", 50)
		crearColumnaParaTabla(tablaFunciones, "Sala", "nombreSala", 200)
	}

}
