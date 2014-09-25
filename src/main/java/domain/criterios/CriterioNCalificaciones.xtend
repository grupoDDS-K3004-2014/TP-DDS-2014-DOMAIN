package domain.criterios

import domain.partido.Partido
import domain.jugadores.Participante

class CriterioNCalificaciones implements Criterio {

	@Property int cantidadCalificaciones
	
	override devolverCriterio(Partido partido) {
		[Participante participante| participante.ultimasNotas(cantidadCalificaciones)]
	}

	
}
