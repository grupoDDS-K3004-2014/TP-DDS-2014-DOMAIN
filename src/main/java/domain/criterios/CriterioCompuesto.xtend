package domain.criterios

import domain.jugadores.Participante
import java.util.ArrayList
import org.uqbar.commons.model.Entity

class CriterioCompuesto extends Entity implements Criterio {

	@Property ArrayList<Criterio> criterios = new ArrayList<Criterio>

	def agregarCriterio(Criterio criterio) {
		criterios.add(criterio)
	}

	override actualizarPuntajeCriterio(Participante participante2) {

		criterios.forEach[criterio|criterio.actualizarPuntajeCriterio(participante2)]
	}

}
