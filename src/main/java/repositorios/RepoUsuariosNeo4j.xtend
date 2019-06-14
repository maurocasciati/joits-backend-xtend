package repositorios

import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import domain.Usuario

class RepoUsuariosNeo4j extends AbstractRepoNeo4j {

	static RepoUsuariosNeo4j instance

	def static RepoUsuariosNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoUsuariosNeo4j
		}
		instance
	}

//	def static void main(String[] args) {
//		new RepoPeliculas => [
//			getPeliculas(new PeliculaBusqueda => [
//				valorABuscar = "Fros"
//			])
//		]
//	}
//	def List<Usuario> getUsuario(PeliculaBusqueda peliculaBusqueda) {
//		// En getPeliculas queremos hacer la búsqueda con profundidad (depth) = 0
//		// para traer únicamente el nodo película sin la relación
//		return new ArrayList(
//			session.loadAll(typeof(Pelicula), filtroPeliculas(peliculaBusqueda), PROFUNDIDAD_BUSQUEDA_LISTA))
//	}
//
//	def Filters filtroPeliculas(PeliculaBusqueda peliculaBusqueda) {
//		// Construyo un filtro que no filtra, para que filtroPeliculas devuelva siempre Filters
//		var filtroTrue = new Filter("title", ComparisonOperator.MATCHES, ".*")
//		val filtroPorTitulo = new Filter("title", ComparisonOperator.MATCHES,
//			".*(?i)" + peliculaBusqueda.valorABuscar + ".*")
//		val filtroPorAnio = new Filter("released", ComparisonOperator.EQUALS, peliculaBusqueda.anioABuscar)
//		if (peliculaBusqueda.filtraPorAnio) {
//			// Solo busca por año
//			if (!peliculaBusqueda.seleccionoConector) {
//				return filtroPorAnio.and(filtroTrue)
//			}
//			if (peliculaBusqueda.hasAnd) {
//				return filtroPorTitulo.and(filtroPorAnio)
//			}
//			if (peliculaBusqueda.hasOr) {
//				return filtroPorTitulo.or(filtroPorAnio)
//			}
//		}
//		filtroPorTitulo.and(filtroTrue)
//	}
	def Usuario getUsuario(Long id) {
		session.load(Usuario, id, PROFUNDIDAD_BUSQUEDA_CONCRETA)
	}

//	def void eliminarPelicula(Pelicula pelicula) {
//		session.delete(pelicula)
//	}
//
//	/**
//	 * Contra, tuve que agregar el eliminarPersonaje porque la actualización en cascada
//	 * no detectó la ausencia de una relación, quizás por la forma en que está configurada
//	 */
//	def void eliminarPersonaje(Personaje personaje) {
//		session.delete(personaje)
//	}
//
	def void guardarUsuario(Usuario usuario) {
		session.save(usuario)
	// ver save(entity, depth). Aquí por defecto depth es -1 que
	// implica hacer una pasada recorriendo todo el grafo en profundidad
	}

	def void crearUsuarios(List<Usuario> usuarios) {
		usuarios.forEach[user|this.guardarUsuario(user)]
	}

}
