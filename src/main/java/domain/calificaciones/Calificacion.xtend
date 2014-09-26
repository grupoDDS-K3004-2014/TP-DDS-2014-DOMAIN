package domain.calificaciones

class Calificacion {
	@Property int nota
	@Property String descripcion
	@Property String fecha

	def calificacionCorrecta() {
		nota >= 1 && nota <= 10
	}

	def static Calificacion nueva(Integer nota2, String descripcion2, String fecha2) {
		var calificacion = new Calificacion
		calificacion.nota = nota2
		calificacion.descripcion = descripcion2
		calificacion.fecha = fecha2
		calificacion
	}

}
