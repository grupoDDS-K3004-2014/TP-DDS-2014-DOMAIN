package domain.infracciones

class Infraccion {

	@Property String fecha
	@Property String motivo

	def igual(Infraccion infraccionAComparar) {
		fecha == infraccionAComparar.fecha && motivo == infraccionAComparar.motivo
	}
		

}
