package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.math.BigDecimal
import repositorios.Entidad

@Accessors
class Usuario extends Entidad {
	String nombre
	String apellido
	Integer edad
	List<Usuario> listaDeAmigos
	BigDecimal saldo
	String contrasenia
	List<Entrada> entradas
	
	def historial() {}
}
