package domain

class NotificarConfirmacionAAmigosObserver implements Observer {

	@Property ServidorDeEmails servidorEmails = new ServidorDeEmails

	override notificarAlta(Participante observable) {
		servidorEmails.notificarCadena(observable.amigos)
	}

	override notificarBaja() {
	}

}
