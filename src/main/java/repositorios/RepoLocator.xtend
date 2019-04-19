package repositorios

import org.eclipse.xtend.lib.annotations.Accessors

class RepoLocator {

	@Accessors static RepoContenido repoContenido = RepoContenido.getInstance
	@Accessors static RepoUsuario repoUsuario = RepoUsuario.getInstance
	@Accessors static RepoEntrada repoEntrada = RepoEntrada.getInstance
	@Accessors static RepoFuncion repoFuncion = RepoFuncion.getInstance

}
