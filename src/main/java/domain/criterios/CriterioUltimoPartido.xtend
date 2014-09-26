package domain.criterios

import domain.jugadores.Participante

class CriterioUltimoPartido implements Criterio {

	override actualizarPuntajeCriterio(Participante participante) {
		participante.puntajeCriterio = participante.puntajeCriterio + participante.ultimaNota
	}

}
