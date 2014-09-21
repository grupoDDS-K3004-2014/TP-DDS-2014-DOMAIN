package domain

class CriterioHandicap implements Criterio {

	

	override void determinarPuntajeCriterio(Participante participante) {

		participante.puntajesCriterio.add(participante.handicap)
	}
}
