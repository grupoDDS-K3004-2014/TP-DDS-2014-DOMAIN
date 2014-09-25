package domain.condiciones

import domain.partido.Partido

class CondicionHora implements Condicion {

	@Property int horaCondicion

	
	override verificarCondicion(Partido partido) {
		horaCondicion == partido.getHorario
	}

}
