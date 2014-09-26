package domain.criterios

import domain.jugadores.Participante

class CriterioHandicap implements Criterio {

		
	override actualizarPuntajeCriterio(Participante participante) {
		participante.puntajeCriterio=participante.puntajeCriterio+participante.handicap
	}
	
	

}
