package domain

class InfraccionBajaSinRemplazo implements Infraccion {

	@Property int fecha

	def igualA(InfraccionBajaSinRemplazo infraccion) {
		this.fecha == infraccion.fecha
	}

}
