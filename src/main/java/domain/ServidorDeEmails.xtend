package domain
import java.util.ArrayList
import java.util.List

class ServidorDeEmails {

	List<Email> notificaciones = new ArrayList<Email>

	def notificarAdministrador() {
		this.notificar
	}

	def notificar() {
		notificaciones.add(new Email)
	}

	def notificarCadena(ArrayList<Participante> gente) {

		if (gente.size == 0) {
		} else {
			gente.forEach[Participante amigo|this.notificar]
		}
	}

	def cantidadNotificaciones() {
		notificaciones.size
	}
}
