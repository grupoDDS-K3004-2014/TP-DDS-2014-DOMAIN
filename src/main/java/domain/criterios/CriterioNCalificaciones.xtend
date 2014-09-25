package domain.criterios

import domain.partido.Partido

class CriterioNCalificaciones implements Criterio {

	@Property int cantidadCalificaciones

	override determinarPuntajeJugadores(Partido partido) {
		partido.jugadoresOrdenados.forEach[jugador|
			jugador.puntajeCriterio + jugador.ultimasNotas(cantidadCalificaciones)]
	}

}
