package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.math.BigDecimal
import java.util.ArrayList
import java.util.Arrays
import java.util.List
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
class Usuario{
	@Id
	@GeneratedValue
	Long id
	
	
	String nombre
	String apellido
	String username
	Integer edad
	@JsonIgnore transient List<Usuario> listaDeAmigos = new ArrayList<Usuario>
	BigDecimal saldo
	String contrasenia
	transient List<Entrada> entradas = new ArrayList<Entrada>
	transient List<Entrada> carrito = new ArrayList<Entrada>

	def getHistorial() {
		entradas.map[entrada|entrada.contenido.titulo].toSet
	}

	def limpiarCarrito() {
		carrito.clear
	}

	def eliminarItem(Entrada item) {
		carrito.remove(item)
	}

	def finalizarCompra() {
		if (noLeAlcanzaSaldo) {
			throw new UserException("Saldo insuficiente")
		}
		saldo -= new BigDecimal(totalCarrito)
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
		saldo = saldo + new BigDecimal(monto)
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

}
