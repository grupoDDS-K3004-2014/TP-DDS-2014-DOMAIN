package domain

import java.util.ArrayList
import org.uqbar.commons.model.Entity

class CriterioCompuesto extends Entity implements Criterio {
	@Property ArrayList<Criterio> criterios = new ArrayList<Criterio>

	override void determinarPuntajeCriterio(Participante participante) {

		criterios.forEach[Criterio criterio|criterio.determinarPuntajeCriterio(participante)]

	}
}
