package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.FetchType
import java.util.Objects
import javax.persistence.CascadeType

@Entity
@Accessors
@Observable
class Entrada {
	@Id
	@GeneratedValue
	Long id

	@ManyToOne(fetch=FetchType.LAZY)
	Contenido contenido

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
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
}
