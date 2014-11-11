package domain.infracciones

import javax.persistence.Entity

@Entity
class InfraccionBajaSinRemplazo extends Infraccion {
	
	
	def static InfraccionBajaSinRemplazo nueva(String fecha2, String motivo2) {
		var infraccion = new InfraccionBajaSinRemplazo
		infraccion.fecha = fecha2
		infraccion.motivo = motivo2
		infraccion

	}

}
