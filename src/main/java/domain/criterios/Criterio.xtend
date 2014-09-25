package domain.criterios

import domain.jugadores.Participante
import domain.partido.Partido

interface Criterio {

	def (Participante)=>Integer devolverCriterio(Partido partido)
}
