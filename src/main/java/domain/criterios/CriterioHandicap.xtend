package domain.criterios

import domain.jugadores.Participante
import javax.persistence.Entity

@Entity
class CriterioHandicap extends Criterio {

		
	override actualizarPuntajeCriterio(Participante participante) {
		participante.puntajeCriterio=participante.puntajeCriterio+participante.handicap
	}
	
	

}
