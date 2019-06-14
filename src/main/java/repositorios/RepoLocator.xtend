package repositorios

import org.eclipse.xtend.lib.annotations.Accessors

class RepoLocator {

	@Accessors static RepoContenido repoContenido = RepoContenido.getInstance
	@Accessors static RepoUsuario repoUsuario = RepoUsuario.getInstance
	@Accessors static RepoCarrito repoCarrito = RepoCarrito.getInstance
	@Accessors static RepoUsuariosNeo4j repoUsuarioNeo = RepoUsuariosNeo4j.getInstance
	
	

}
