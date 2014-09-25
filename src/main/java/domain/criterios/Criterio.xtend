package domain.criterios

import domain.partido.Partido

interface Criterio {

	def void determinarPuntajeJugadores(Partido partido)
	
}
