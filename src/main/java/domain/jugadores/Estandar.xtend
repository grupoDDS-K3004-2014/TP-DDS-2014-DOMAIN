package domain.jugadores

import domain.partido.Partido

class Estandar extends Participante {

	override  ubicarse(Partido partido) {
		partido.estandares.add(this)
		partido.notificarAltaObservers(this)
	}

}
