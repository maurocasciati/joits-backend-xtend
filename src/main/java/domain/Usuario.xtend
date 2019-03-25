package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.math.BigDecimal
import repositorios.Entidad
import java.util.ArrayList
import org.uqbar.commons.model.exceptions.UserException
import java.util.Arrays

@Accessors
class Usuario extends Entidad {
	String nombre
	String apellido
	String username
	Integer edad
	List<Usuario> listaDeAmigos
	BigDecimal saldo
	String contrasenia
	List<Entrada> entradas
	List<Contenido> historial
	List<Entrada> carrito = new ArrayList<Entrada>

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
		limpiarCarrito
	}

	def noLeAlcanzaSaldo() {
		totalCarrito > saldo.doubleValue
	}

	def totalCarrito() {
		var double[] precios = getCarrito.map[entrada|entrada.precio]
		Arrays.stream(precios).sum();
	}
}
