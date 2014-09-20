package domain
class NotificarEquipoCompletoConseguidoOPerdidoObserver implements Observer {

	@Property int confirmados = 0
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
