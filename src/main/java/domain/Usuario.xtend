package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.math.BigDecimal
import java.util.Arrays
import java.util.HashSet
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
import java.util.Objects

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

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JsonIgnore
	Set<Usuario> listaDeAmigos = new HashSet<Usuario>

	@Column(nullable=false)
	BigDecimal saldo

	@Column(length=256)
	@JsonIgnore
	String passwordHash

	@Column(length=250)
	String imagenURL

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumn(name="id_usuario")
	@JsonIgnore
	Set<Entrada> entradas = new HashSet<Entrada>

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumn(name="id_usuario_carrito")
	@JsonIgnore
	Set<Entrada> carrito = new HashSet<Entrada>

	@JsonIgnore
	def getHistorial() {
		entradas.map[entrada|entrada.contenido.titulo].toSet
	}

	def limpiarCarrito() {
		carrito = new HashSet
	}

	def eliminarItem(Entrada item) {
		carrito.remove(item)
	}

	def finalizarCompra() {
		if (noLeAlcanzaSaldo) {
			throw new UserException("Saldo insuficiente")
		}
		saldo -= new BigDecimal(totalCarrito.toString)
		agregarEntradasCarrito
		limpiarCarrito
	}

	def agregarEntradasCarrito() {
		carrito.forEach[entrada|entrada.asignarFechaCompra]
		carrito.forEach[entrada|entradas.add(entrada)]
	}

	def agregarAlCarrito(Entrada entrada) {
		carrito.add(entrada)
	}

	def noLeAlcanzaSaldo() {
		totalCarrito > saldo.doubleValue
	}

	def totalCarrito() {
		var double[] precios = getCarrito.map[entrada|entrada.precio]
		Arrays.stream(precios).sum();
	}

	def cargarSaldo(Double monto) {
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
