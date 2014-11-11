package domain.jugadores

import domain.partido.Partido
import javax.persistence.Entity

@Entity
class Estandar extends Participante {

	override  ubicarse(Partido partido) {
		partido.estandares.add(this)
		partido.notificarAltaObservers(this)
	}

}
