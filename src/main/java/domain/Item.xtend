package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDateTime
import java.util.Objects
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.OnDelete
import org.hibernate.annotations.OnDeleteAction
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
class Item {
	@Id
	@GeneratedValue
	Long id

	@ManyToOne
	@OnDelete(action=OnDeleteAction.CASCADE)
	@JoinColumn(name="contenido_id")
	Contenido contenido

	@ManyToOne(fetch=FetchType.LAZY)
	@OnDelete(action=OnDeleteAction.CASCADE)
	@JoinColumn(name="funcion_id")
	Funcion funcion

	@Column
	LocalDateTime fechaCompra

	new(Contenido _contenido, Funcion _funcion) {
		contenido = _contenido
		funcion = _funcion
	}

	new() {
	}

	def Double getPrecio() {
		contenido.precio + funcion.precio
	}

	def asignarFechaCompra() {
		fechaCompra = LocalDateTime.now
	}

	@JsonIgnore
	def getPrecioString() {
		"$" + precio.toString
	}

	override equals(Object other) {
		if (other instanceof Item) {
			return (other as Item).id == id
		}
		false
	}

	override hashCode() {
		Objects.hashCode(id)
	}
}
