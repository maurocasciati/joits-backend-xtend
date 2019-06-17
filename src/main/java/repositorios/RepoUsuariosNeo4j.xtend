package repositorios

import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import domain.Usuario
import domain.Entrada
import java.util.HashMap
import java.util.Map
import java.util.Set
import domain.Contenido
import domain.Pelicula

class RepoUsuariosNeo4j extends AbstractRepoNeo4j {

	static RepoUsuariosNeo4j instance

	def static RepoUsuariosNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoUsuariosNeo4j
		}
		instance
	}

	def peliculasRecomendadas(Long id) {
		var Map<String, Object> params = new HashMap<String, Object>(1);
		var String cypher = "match (entradas_usuario)-[:TIENE_ENTRADA]-(usuario)-[:ES_AMIGO]-(amigos)-[:TIENE_ENTRADA]-(entradas_amigos)
		WHERE ID(usuario) = " + id.toString + " with collect(entradas_usuario.tituloContenido) as entradas,
		entradas_amigos as entradas_amigo
		where not entradas_amigo.tituloContenido in entradas
		RETURN distinct entradas_amigo.tituloContenido
		LIMIT 5"
		val peliculas = new ArrayList<Contenido>
		val entradas = session.query(String, cypher, params).toList;
		entradas.forEach[entrada|peliculas.add(RepoLocator.repoContenido.searchByTitle(entrada))]
		peliculas.forEach[pelicula | println(pelicula.titulo)]
		peliculas

	}

//		val filtroPorNombreActor = 
//			new Filter("name", ComparisonOperator.MATCHES, "(?i).*" + valor + ".*")
//		return new ArrayList(session.loadAll(typeof(Actor), filtroPorNombreActor, PROFUNDIDAD_BUSQUEDA_LISTA))
//		session.countEntitiesOfType(Entrada)
//	}
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
		session.save(usuario, PROFUNDIDAD_BUSQUEDA_CONCRETA)
	// ver save(entity, depth). Aquí por defecto depth es -1 que
	// implica hacer una pasada recorriendo todo el grafo en profundidad
	}

	def void crearUsuarios(List<Usuario> usuarios) {
		usuarios.forEach[user|this.guardarUsuario(user)]
	}

}
