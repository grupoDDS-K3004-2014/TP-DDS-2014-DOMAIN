package domain.observers

import domain.jugadores.Participante
import domain.notificaciones.ServidorDeEmails
import javax.persistence.Entity
import javax.persistence.OneToOne

@Entity
class NotificarConfirmacionAAmigosObserver extends Observer {

	@OneToOne
	@Property ServidorDeEmails servidorEmails = new ServidorDeEmails

	override notificarAlta(Participante observable) {
		servidorEmails.notificarCadena(observable.amigos)
	}

	override notificarBaja() {
	}

}
