package domain.calificaciones

class Calificacion {
	@Property int nota
	@Property String descripcion
	@Property String fecha

	def calificacionCorrecta() {
		nota >= 1 && nota <= 10
	}

}
