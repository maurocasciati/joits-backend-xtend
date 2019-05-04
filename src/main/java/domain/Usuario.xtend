package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.math.BigDecimal
import java.util.HashSet
import java.util.Objects
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.hibernate.annotations.OnDelete
import org.hibernate.annotations.OnDeleteAction
import java.util.List
import java.util.ArrayList

@Entity
@Accessors
@Observable
class Usuario {
	@Id
	@GeneratedValue
	Long id

	@Column(length=50)
	String nombre

	@Column(length=50)
	String apellido

	@Column(length=50)
	String username

	@Column
	Integer edad

	@ManyToMany(fetch=FetchType.LAZY)
	@JsonIgnore
	Set<Usuario> listaDeAmigos = new HashSet<Usuario>

	@Column(nullable=false)
	BigDecimal saldo

	@Column(length=256)
	@JsonIgnore
	String passwordHash

	@Column(length=250)
	String imagenURL

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL, orphanRemoval=true)
	@JoinColumn(name="usuario_id")
	@JsonIgnore
	List<Entrada> entradas = new ArrayList<Entrada>

	new() {
	}

	new(Long _id, String _nombre, String _apellido) {
		id = _id
		nombre = _nombre
		apellido = _apellido
	}

	@JsonIgnore
	def getHistorial() {
		entradas.map[entrada|entrada.contenido.titulo].toSet
	}

	def finalizarCompra(Carrito carrito) {
		if (noLeAlcanzaSaldo(carrito)) {
			throw new UserException("Saldo insuficiente")
		}
		saldo -= new BigDecimal(carrito.totalCarrito.toString)
		agregarEntradasDeCarrito(carrito)
		carrito.limpiarCarrito
	}

	def agregarEntradasDeCarrito(Carrito carrito) {
		carrito.entradas.forEach[entrada|entrada.asignarFechaCompra]
		carrito.entradas.forEach[entrada|entradas.add(entrada)]
	}

	def noLeAlcanzaSaldo(Carrito carrito) {
		carrito.totalCarrito > saldo.doubleValue
	}

	def cargarSaldo(Double monto) {
		if (monto > 100000) {
			throw new UserException("No se puede cargar mas de $100000")
		}
		saldo = saldo + new BigDecimal(monto.toString)
	}

	def Boolean coincideEnBusqueda(String valorBuscado) {
		if (valorBuscado === null) {
			throw new UserException("No se ingresó ningún valor de búsqueda")
		} else {
			coincide(nombre, valorBuscado) || coincide(apellido, valorBuscado) || coincide(username, valorBuscado)
		}
	}

	def Boolean coincide(String valorUsuario, String valorBuscado) {
		StringUtils.containsIgnoreCase(valorUsuario, valorBuscado)
	}

	def agregarAmigo(Usuario usuario) {
		if(!listaDeAmigos.contains(usuario)) listaDeAmigos.add(usuario)
	}

	def void eliminarAmigo(Usuario amigo) {
		listaDeAmigos.remove(amigo)
	}

	override equals(Object other) {
		if (other instanceof Usuario) {
			return (other as Usuario).id == id
		}
		false
	}

	override hashCode() {
		Objects.hashCode(id)
	}

}
