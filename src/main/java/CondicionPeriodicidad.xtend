class CondicionPeriodicidad implements Condicion {

	@Property int periodicidadCondicion

	override verificarCondicion(Partido partido) {

		periodicidadCondicion == partido.getPeriodicidad

	}

}
