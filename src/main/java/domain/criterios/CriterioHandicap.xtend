package domain.criterios

import domain.partido.Partido
import domain.jugadores.Participante

class CriterioHandicap implements Criterio {

	
	
	override devolverCriterio(Partido partido) {
		blockFunction
	}
	
	def blockFunction() {
		[Participante jugador| jugador.handicap]
	}
	
	def blockTest2(){
		[Integer i| 0 ]
	}
	
}
