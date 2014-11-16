package domain.notificaciones

import domain.jugadores.Participante
import java.util.HashSet
import java.util.Set
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany

@Entity
class ServidorDeEmails {

	@Id
	@GeneratedValue
	@Property long id

	@OneToMany
	@Property Set<Email> notificaciones = new HashSet<Email>

	def notificarAdministrador() {
		this.notificar
	}

	def notificar() {
		notificaciones.add(new Email)
	}

	def notificarCadena(Set<Participante> gente) {

		if (gente.size == 0) {
		} else {
			gente.forEach[Participante amigo|this.notificar]
		}
	}

	def cantidadNotificaciones() {
		notificaciones.size
	}
}
