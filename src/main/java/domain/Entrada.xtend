package domain

import java.time.LocalDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Property
import org.neo4j.ogm.annotation.RelationshipEntity
import org.uqbar.commons.model.annotations.Observable
import org.neo4j.ogm.annotation.NodeEntity

@Entity
//@RelationshipEntity(type="TIENE_ENTRADA")
@NodeEntity
@Accessors
@Observable
class Entrada {
	@Id
	@org.neo4j.ogm.annotation.Id
	@GeneratedValue
//	@GeneratedValue
	Long id

	@Column
	@Property
	String tituloContenido
	
	@Column
	@Property
	String generoContenido
	
	@Column
	LocalDateTime fechaCompra

//No los persistimos porque no son requerimientos de los casos de uso.
//	Double precio
//
//	LocalDateTime fechaFuncion


	new(String titulo, String genero) {
		tituloContenido = titulo
		generoContenido = genero
		fechaCompra = LocalDateTime.now
	}

	new() {
	}

}
