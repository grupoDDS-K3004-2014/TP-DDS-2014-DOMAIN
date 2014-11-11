package domain.condiciones

import domain.partido.Partido
import javax.persistence.Entity

@Entity
class CondicionPeriodicidad extends Condicion {

	@Property int periodicidadCondicion

		
	override verificarCondicion(Partido partido) {
		periodicidadCondicion == partido.getPeriodicidad
	}

}
