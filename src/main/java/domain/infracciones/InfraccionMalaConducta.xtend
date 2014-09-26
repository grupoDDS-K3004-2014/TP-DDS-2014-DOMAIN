package domain.infracciones

class InfraccionMalaConducta extends Infraccion {


	def static InfraccionMalaConducta nueva(String fecha2, String motivo2) {
		var infraccion = new InfraccionMalaConducta
		infraccion.fecha = fecha2
		infraccion.motivo = motivo2
		infraccion

	}

}
