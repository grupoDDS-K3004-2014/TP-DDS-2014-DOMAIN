package domain.condiciones

import domain.partido.Partido
import javax.persistence.Entity

@Entity
class CondicionHora extends Condicion {

	@Property int horaCondicion

	
	override verificarCondicion(Partido partido) {
		horaCondicion == partido.getHorario
	}

}
