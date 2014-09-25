package domain.jugadores

import java.util.ArrayList
import java.util.Collection
import domain.partido.Partido
import domain.condiciones.Condicion

class Condicional extends Participante {

	@Property Collection<Condicion> condiciones = new ArrayList<Condicion>

	def condicionesCumplidas(Partido partido) {

		condiciones.forall[Condicion condicion|condicion.verificarCondicion(partido)]

	}

	def agregarCondicion(Condicion condicion) {
		condiciones.add(condicion)
	}

	override ubicarse(Partido partido) {
		if (condicionesCumplidas(partido)) {
			partido.condicionales.add(this)
			partido.notificarAltaObservers(this)
		}

	}
}
