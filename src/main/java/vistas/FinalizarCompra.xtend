package vistas

import domain.Entrada
import domain.Usuario
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

class FinalizarCompra extends Ventana<FinalizarCompraViewModel> {

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
		val tabla = new Table<Entrada>(panel, typeof(Entrada)) => [
			items <=> listado
			value <=> "itemSeleccionado"
			numberVisibleRows = filas
		]

		crearColumnaParaTabla(tabla, "Nombre", "funcion.contenido.titulo", 200)
		crearColumnaParaTabla(tabla, "Rating", "funcion.contenido.puntaje", 50)
		crearColumnaParaTabla(tabla, "Género", "funcion.contenido.genero", 100)
		crearColumnaParaTabla(tabla, "Precio", "precio", 100)
	}

	def eliminarItem() {
		modelObject.eliminarItem
		actualizarVista(modelObject, "carrito")
	}

	def vaciarCarrito() {
		modelObject.limpiarCarrito
		actualizarVista(modelObject, "carrito")
	}

	def volverAtras() {
		close
	}

	def comprar() {
		modelObject.finalizarCompra
		volverAtras
	}
}
