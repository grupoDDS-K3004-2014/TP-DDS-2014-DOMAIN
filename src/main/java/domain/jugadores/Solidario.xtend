package domain.jugadores

import domain.partido.Partido
import javax.persistence.Entity

@Entity
class Solidario extends Participante {

	
	override ubicarse(Partido partido) {
		partido.solidarios.add(this)
		partido.notificarAltaObservers(this)
	}
	
}
