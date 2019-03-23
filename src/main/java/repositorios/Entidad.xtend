package repositorios

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
abstract class Entidad {
	@Accessors int id
}
