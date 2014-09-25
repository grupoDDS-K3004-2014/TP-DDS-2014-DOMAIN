package domain.observers

import domain.jugadores.Participante
import domain.notificaciones.ServidorDeEmails

class NotificarConfirmacionAAmigosObserver implements Observer {

	@Property ServidorDeEmails servidorEmails = new ServidorDeEmails

	override notificarAlta(Participante observable) {
		servidorEmails.notificarCadena(observable.amigos)
	}

	override notificarBaja() {
	}

}
