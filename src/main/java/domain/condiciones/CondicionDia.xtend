package domain.condiciones

import domain.partido.Partido

class CondicionDia implements Condicion {

	@Property domain.Dia diaCondicion

	override verificarCondicion(Partido partido) {

		diaCondicion == partido.getDia

	}

}
