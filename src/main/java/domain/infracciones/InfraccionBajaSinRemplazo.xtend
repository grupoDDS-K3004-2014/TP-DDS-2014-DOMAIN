package domain.infracciones

class InfraccionBajaSinRemplazo extends Infraccion {

	
	def igualA(InfraccionBajaSinRemplazo infraccion) {
		this.fecha == infraccion.fecha
	}

}
