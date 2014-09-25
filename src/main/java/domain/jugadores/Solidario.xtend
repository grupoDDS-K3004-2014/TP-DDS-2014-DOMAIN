package domain.jugadores

import domain.partido.Partido

class Solidario extends Participante {

	
	override ubicarse(Partido partido) {
		partido.solidarios.add(this)
		partido.notificarAltaObservers(this)
	}
	
}
