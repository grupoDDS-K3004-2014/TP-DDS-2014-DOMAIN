package domain
import java.util.ArrayList
import java.util.Date

class Propuesta {

	@Property String nombre
	@Property Date fechaDeNacimiento
	@Property ArrayList<Participante> amigos = new ArrayList<Participante>
	@Property Participante modalidad

	def cargarDatos() {
		modalidad.nombre = nombre
		modalidad.fechaNacimiento = fechaDeNacimiento
		modalidad.amigos = amigos
	}

}
