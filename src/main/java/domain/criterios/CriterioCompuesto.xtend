package domain.criterios

import java.util.ArrayList
import org.uqbar.commons.model.Entity
import domain.partido.Partido

class CriterioCompuesto extends Entity implements Criterio {
	@Property ArrayList<Criterio> criterios = new ArrayList<Criterio>

	override devolverCriterio(Partido partido) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
