package domain.criterios

import domain.partido.Partido
import domain.jugadores.Participante

class CriterioHandicap implements Criterio {

	
	
	override devolverCriterio(Partido partido) {
		[Participante jugador| jugador.handicap]
	}
	
}
