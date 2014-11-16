package domain.observers

import domain.notificaciones.ServidorDeEmails
import domain.jugadores.Participante
import javax.persistence.Entity
import javax.persistence.OneToOne

@Entity
class NotificarEquipoCompletoConseguidoOPerdidoObserver extends Observer {

	@Property int confirmados = 0

	@OneToOne
	@Property ServidorDeEmails servidorEmails = new ServidorDeEmails

	override notificarAlta(Participante observable) {
		confirmados = confirmados + 1
		if (confirmados == 2) {
			servidorEmails.notificarAdministrador
		}

	}

	override notificarBaja() {
		if (confirmados == 2) {
			servidorEmails.notificarAdministrador
		}
		confirmados = confirmados - 1
	}

}
