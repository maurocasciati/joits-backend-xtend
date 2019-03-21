package domain

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.math.BigDecimal

@Accessors
class Usuario {
		String nombre
		String apellido
		Integer edad
		List<Usuario> listaDeAmigos
		BigDecimal saldo
		List<Contenido> historial
}