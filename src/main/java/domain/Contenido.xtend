package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.JoinColumn
import java.util.Objects
import com.fasterxml.jackson.annotation.JsonIgnore

@Observable
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipo", discriminatorType=DiscriminatorType.INTEGER)
@Accessors
abstract class Contenido {
	@Id
	@GeneratedValue
	Long id

	@Column(length=150)
	String titulo

	@Column
	Double puntaje

	@Column(length=100)
	String genero // accion, comedia, drama, ciencia ficcion	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumn(name="id_contenido")
	@JsonIgnore
	List<Funcion> funciones = new ArrayList<Funcion>

	@Column(length=60)
	String apiID

	def Double precio()

	def Integer getAnio()

	def searchFuncionById(Long id) {
		funciones.findFirst[funcion|funcion.id == id]
	}

	override equals(Object other) {
		if (other instanceof Contenido) {
			return (other as Contenido).id == id
		}
		false
	}

	override hashCode() {
		Objects.hashCode(id)
	}

}
