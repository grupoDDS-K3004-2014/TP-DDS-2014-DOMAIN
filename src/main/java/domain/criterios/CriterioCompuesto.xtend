package domain.criterios

import domain.partido.Partido
import java.util.ArrayList
import org.uqbar.commons.model.Entity

class CriterioCompuesto extends Entity implements Criterio {

	@Property ArrayList<Criterio> criterios = new ArrayList<Criterio>

	override determinarPuntajeJugadores(Partido partido) {
	criterios.forEach[criterio| criterio.determinarPuntajeJugadores(partido)]
	}
	
	def agregarCriterio(Criterio criterio) {
		criterios.add(criterio)
	}
	
	

}
