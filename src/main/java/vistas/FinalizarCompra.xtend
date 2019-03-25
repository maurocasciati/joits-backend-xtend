package vistas

import domain.Entrada
import domain.Usuario
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.model.utils.ObservableUtils
import viewModels.FinalizarCompraViewModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class FinalizarCompra extends Dialog<FinalizarCompraViewModel> {

	new(WindowOwner parent, Usuario usuarioLogueado) {
		super(parent, new FinalizarCompraViewModel)
		modelObject.usuarioLogueado = usuarioLogueado
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
				agregarLineaValor("Total: ", "total")
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
		new Table<Entrada>(panel, typeof(Entrada)) => [
			items <=> listado
			value <=> "itemSeleccionado"
			numberVisibleRows = filas
			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("funcion.contenido.titulo")
				fixedSize = 200
			]
			new Column(it) => [
				title = "Rating"
				bindContentsToProperty("funcion.contenido.puntaje")
				fixedSize = 50
			]
			new Column(it) => [
				title = "Género"
				bindContentsToProperty("funcion.contenido.genero")
				fixedSize = 100
			]
			new Column(it) => [
				title = "Precio"
				bindContentsToProperty("precio")
				fixedSize = 100
			]
		]

	}

	def eliminarItem() {
		modelObject.eliminarItem
		actualizarVista("carrito")
	}

	def vaciarCarrito() {
		modelObject.limpiarCarrito
		actualizarVista("carrito")
	}

	def actualizarVista(String propiedad) {
		ObservableUtils.firePropertyChanged(this.modelObject, propiedad)
	}

	def volverAtras() {
		this.cancel
	}

	def comprar() {
		modelObject.finalizarCompra
		volverAtras
	}
}
