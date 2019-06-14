package repositorios

import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.config.Configuration
import org.neo4j.ogm.session.SessionFactory

@Accessors
abstract class AbstractRepoNeo4j {

	/**
	 * Al buscar muchos elementos, buscaremos por defecto traer solo la información de ese nodo, por eso 0.
	 * Al buscar un nodo concreto, la profundidad será 1 para traer el nodo y sus relaciones
	 */
	public static int PROFUNDIDAD_BUSQUEDA_LISTA = 0
	public static int PROFUNDIDAD_BUSQUEDA_CONCRETA = 1

	/**
	 * http://neo4j.com/docs/ogm-manual/current/reference/
	 * 
	 */
	static Configuration configuration = new Configuration.Builder().uri("bolt://localhost").credentials("neo4j",
		"lamarr").build()

	public static SessionFactory sessionFactory = new SessionFactory(configuration, "domain")

	protected def getSession() {
		sessionFactory.openSession
	}

}
