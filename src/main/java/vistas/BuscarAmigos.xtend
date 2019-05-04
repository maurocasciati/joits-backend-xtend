package vistas

import domain.Usuario
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import viewModels.BuscarAmigosViewModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BuscarAmigos extends Ventana<BuscarAmigosViewModel> {

	new(WindowOwner owner, Usuario usuarioLogueado) {
		super(owner, new BuscarAmigosViewModel(usuarioLogueado))
	}

	override addActions(Panel actionsPanel) {
	}

	override createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		new GroupPanel(mainPanel) => [
			layout = new VerticalLayout
			title = "Buscar Persona"
			agregarBuscador("Buscar usuario: ", "valorBuscado", "resultados", 50)
			new Panel(it) => [
				width = 200
				agregarTablaUsuarios("resultados", "usuarioSeleccionado", 8)
			]
			new Button(it) => [
				caption = "Agregar a amigos"
				bindEnabled(new NotNullObservable("usuarioSeleccionado"))
				onClick[
					modelObject.agregarAmigo
					actualizarVista("resultados")
					actualizarVista("listadoSugeridos")
				]
				width = 100
			]
		]
		new GroupPanel(mainPanel) => [
			title = "Amigos sugeridos"
			new Panel(it) => [
				width = 200
				agregarTablaUsuarios("listadoSugeridos", "usuarioSeleccionado", 3)
			]
		]
		new Panel(mainPanel) => [
			layout = new HorizontalLayout

			new Button(it) => [
				caption = "Cancelar"
				onClick[
					close
				]
				width = 100
			]
			new Button(it) => [
				caption = "Aceptar"
				enabled <=> "puedeAceptar"
				onClick[
					modelObject.aceptar
					close
				]
				width = 100
			]
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
