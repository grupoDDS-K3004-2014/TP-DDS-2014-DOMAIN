package domain.infracciones

import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.InheritanceType
import javax.persistence.Inheritance

@Entity
@Observable
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
class Infraccion  {

	@Id
	@GeneratedValue
	@Property long id
	@Property String fecha
	@Property String motivo

	def igual(Infraccion infraccionAComparar) {
		fecha == infraccionAComparar.fecha && motivo == infraccionAComparar.motivo
	}

}
