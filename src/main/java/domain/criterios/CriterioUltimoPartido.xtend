package domain.criterios

import domain.partido.Partido
import domain.jugadores.Participante

class CriterioUltimoPartido implements Criterio {

	override devolverCriterio(Partido partido) {
		[Participante participante|participante.ultimaNota]
	}

}
