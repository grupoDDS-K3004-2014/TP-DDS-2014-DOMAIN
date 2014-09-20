class Estandar extends Participante {

	override inscripcion(Partido partido) {
		if (partido.cantidadParticipantes < 10) {
			partido.agregarParticipante(this)
		} else {
			reemplazarSegunPrioridad(partido, this)
		}
	}

	// 	(partido.dameListCondicionales.get(0)) primer condicional de la lista
	override reemplazarSegunPrioridad(Partido partido, Participante jugador) {
		if (partido.condicionales.size != 0) {
			(partido.condicionales.get(0)).desplazarCondicional(partido)
		} else {
			(partido.solidarios.get(0)).desplazarSolidario(partido)
		}
		partido.agregarParticipante(jugador)

	}

}
