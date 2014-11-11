package domain.jugadores

import java.util.HashSet
import java.util.Set

class Propuesta {

	@Property String nombre
	@Property String fechaDeNacimiento
	@Property Set<Participante> amigos = new HashSet<Participante>
	@Property Participante modalidad

	def cargarDatos() {
		modalidad.nombre = nombre
		modalidad.fechaNacimiento = fechaDeNacimiento
		modalidad.amigos = amigos
	}

}
