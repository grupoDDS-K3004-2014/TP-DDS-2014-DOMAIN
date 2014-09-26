package domain.infracciones

import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.Entity

@Observable
class Infraccion extends Entity {

	@Property String fecha
	@Property String motivo

	def igual(Infraccion infraccionAComparar) {
		fecha == infraccionAComparar.fecha && motivo == infraccionAComparar.motivo
	}

}
