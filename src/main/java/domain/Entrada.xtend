package domain

import java.time.LocalDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
class Entrada {
	@Id
	@GeneratedValue
	Long id

	@Column
	String tituloContenido
	
	@Column
	LocalDateTime fechaCompra

//No los persistimos porque no son requerimientos de los casos de uso.
//	Double precio
//
//	LocalDateTime fechaFuncion


	new(String titulo) {
		tituloContenido = titulo
		fechaCompra = LocalDateTime.now
	}

	new() {
	}

}
