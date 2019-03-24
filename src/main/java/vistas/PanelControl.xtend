package vistas

import org.uqbar.arena.windows.Window
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
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.commons.model.IModel
import domain.Usuario
import org.uqbar.arena.widgets.List

class PanelControl extends Window<PanelControlViewModel> {

	new(WindowOwner owner, PanelControlViewModel model) {
		super(owner, model)
	}

	override createContents(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		val izquierda = new Panel(mainPanel)
		val derecha = new Panel(mainPanel)

		new Panel(izquierda) => [
			layout = new ColumnLayout(2)
			new Label(it).text = "Usuario"
			new Label(it).text = "nombreApellidoUsuario"
			new Label(it).text = "Edad"
			new TextBox(it) => [
				value <=> "usuario.edad"
			]
		]

		new Table<Usuario>(izquierda, Usuario) => [
			bindItemsToProperty("usuario.listaDeAmigos")
			numberVisibleRows = 3
			new Column<Usuario>(it) => [
				title = "Nombre"
				bindContentsToProperty("nombre")
			]
			new Column<Usuario>(it) => [
				title = "Apellido"
				bindContentsToProperty("apellido")
			]
		]
		new Panel(izquierda) => [
			new Button(it) => [
				caption = "Buscar Amigos"
				onClick[modelObject.buscarAmigos]
			]
		]

		new Panel(derecha) => [
			layout = new ColumnLayout(2)

			new Label(it).text = "Saldo"
			new Label(it) => [
				value <=> "usuario.saldo"
			]
			new Label(it).text = "Cargar Saldo"

			new NumericField(it) => [
				value <=> "saldoParaCargar"
			]
			new Button(derecha) => [
				caption = "Agregar"
				onClick[modelObject.cargarSaldo]
			]
			new Label(it).text = "Pelis vistas"
			
			new List(it) => [
				items <=>"usuario.historial"
			]
		]

	}

}
