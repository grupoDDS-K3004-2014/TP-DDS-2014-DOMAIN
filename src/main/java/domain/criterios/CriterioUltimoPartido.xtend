package domain.criterios

import domain.partido.Partido

class CriterioUltimoPartido implements Criterio {

	override determinarPuntajeJugadores(Partido partido) {
		partido.jugadoresOrdenados.forEach[jugador|jugador.puntajeCriterio + jugador.ultimaNota]
	}

}
