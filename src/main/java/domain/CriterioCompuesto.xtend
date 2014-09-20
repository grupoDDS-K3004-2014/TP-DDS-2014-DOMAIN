package domain
import java.util.ArrayList
import java.util.List

class CriterioCompuesto implements Criterio {
	@Property List<Criterio> criterios = new ArrayList<Criterio>

	override void determinarPuntajeCriterio(Participante participante) {

		criterios.forEach[Criterio criterio|criterio.determinarPuntajeCriterio(participante)]

	}
}
