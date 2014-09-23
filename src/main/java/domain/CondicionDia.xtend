package domain

class CondicionDia implements Condicion {

	@Property Dia diaCondicion

	override verificarCondicion(Partido partido) {

		diaCondicion == partido.getDia

	}

}
