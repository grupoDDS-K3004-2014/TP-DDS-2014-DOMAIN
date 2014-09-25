package domain.jugadores

import java.util.ArrayList

class Propuesta {

	@Property String nombre
	@Property String fechaDeNacimiento
	@Property ArrayList<Participante> amigos = new ArrayList<Participante>
	@Property Participante modalidad

	def cargarDatos() {
		modalidad.nombre = nombre
		modalidad.fechaNacimiento = fechaDeNacimiento
		modalidad.amigos = amigos
	}

}
