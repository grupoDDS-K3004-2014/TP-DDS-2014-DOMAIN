package domain
class CondicionHora implements Condicion {

	@Property int horaCondicion

	override verificarCondicion(Partido partido) {

		horaCondicion == partido.getHorario

	}

}
