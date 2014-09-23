package domain

class Calificacion {
	@Property int nota
	@Property String descripcion
	@Property long fecha

	def calificacionCorrecta() {
		nota >= 1 && nota <= 10
	}

}
