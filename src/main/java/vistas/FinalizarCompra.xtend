package vistas

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import viewModels.FinalizarCompraViewModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import domain.Carrito
import domain.Item

class FinalizarCompra extends Ventana<FinalizarCompraViewModel> {

	new(WindowOwner parent, Long idLogueado, Carrito carrito) {
		super(parent, new FinalizarCompraViewModel(idLogueado, carrito))
	}

	override addActions(Panel actionsPanel) {
	}

	override createFormPanel(Panel mainPanel) {
		this.title = "Joits - Finalizar Compra"
		new Panel(mainPanel) => [
			layout = new VerticalLayout
			new Panel(it) => [
				agregarPanelCarrito()
			]
			new Panel(it) => [
				layout = new HorizontalLayout
				agregarLineaValor("Total:", "total")
				new Button(it) => [
					caption = "Eliminar Item"
					enabled <=> "seleccionoItem"
					onClick[
						eliminarItem
					]
					width = 170
				]

			]
			new Panel(it) => [
				layout = new HorizontalLayout
				new Button(it) => [
					caption = "Limpiar Carrito"
					enabled <=> "carritoNoVacio"
					onClick[
						vaciarCarrito
					]
					width = 170
				]
				new Button(it) => [
					caption = "Comprar"
					enabled <=> "carritoNoVacio"
					onClick[
						comprar
					]
					width = 170
				]
				new Button(it) => [
					caption = "Volver atrás"
					onClick[
						volverAtras
					]
					width = 170
				]

			]
		]
	}

	def agregarLabelPelis(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(panel) => [
				text = "Pelis en el carrito"
			]
		]
	}

	def agregarPanelCarrito(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new GroupPanel(it) => [
				title = "Pelis en el carrito"
				agregarTabla("carrito", 6)
			]
		]

	}

	def agregarTabla(Panel panel, String listado, Integer filas) {
		val tabla = new Table<Item>(panel, typeof(Item)) => [
			items <=> listado
			value <=> "itemSeleccionado"
			numberVisibleRows = filas
		]

		crearColumnaParaTabla(tabla, "Nombre", "contenido.titulo", 200)
		crearColumnaParaTabla(tabla, "Rating", "contenido.puntaje", 50)
		crearColumnaParaTabla(tabla, "Género", "contenido.genero", 100)
		crearColumnaParaTabla(tabla, "Precio", "precioString", 100)
	}

	def eliminarItem() {
		modelObject.eliminarItem
		actualizarVista("carrito")
	}

	def vaciarCarrito() {
		modelObject.limpiarCarrito
		actualizarVista("carrito")
	}

	def volverAtras() {
		close
	}

	def comprar() {
		modelObject.finalizarCompra
		volverAtras
	}
}
