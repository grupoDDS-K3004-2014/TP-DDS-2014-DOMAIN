package domain.condiciones

import domain.partido.Partido

class CondicionPeriodicidad implements Condicion {

	@Property int periodicidadCondicion

		
	override verificarCondicion(Partido partido) {
		periodicidadCondicion == partido.getPeriodicidad
	}

}
