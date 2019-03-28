package vistas

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.model.utils.ObservableUtils

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

abstract class Ventana<T> extends SimpleWindow<T> {

	new(WindowOwner owner, T object) {
		super(owner, object)
	}

	override protected createFormPanel(Panel mainPanel) {
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

	def agregarBuscador(Panel panel, String nombre, String valorBuscado, String listaResultado, int _width) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			alignLeft
		]
		new TextBox(valorPanel) => [
			value <=> valorBuscado
			alignLeft
			width = _width

		]
		new Button(valorPanel) => [
			caption = "Buscar"
			onClick[ObservableUtils.firePropertyChanged(this.modelObject, listaResultado)]
		]
	}

	def actualizarVista(T modelObject, String propiedad) {
		ObservableUtils.firePropertyChanged(modelObject, propiedad)
	}

	def void crearColumnaParaTabla(Table table, String titulo, String propiedad, int _fixedSize) {
		new Column(table) => [
			title = titulo
			fixedSize = _fixedSize
			bindContentsToProperty(propiedad)
		]
	}
}
