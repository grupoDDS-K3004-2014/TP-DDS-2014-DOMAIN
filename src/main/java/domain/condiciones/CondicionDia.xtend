package domain.condiciones

import domain.partido.Partido
import javax.persistence.Entity

@Entity
class CondicionDia extends Condicion {

	@Property String diaCondicion

	override verificarCondicion(Partido partido) {

		diaCondicion == partido.getDia

	}

}
