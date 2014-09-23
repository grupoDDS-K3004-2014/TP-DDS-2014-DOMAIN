package domain

class Solidario extends Participante {

	override inscripcion(Partido partido) {
		if (partido.cantidadParticipantes < 10) {
			partido.agregarParticipante(this)
			partido.agregarSolidario(this)
		} else {
			reemplazarSegunPrioridad(partido, this)
		}
	}

	def desplazarSolidario(Partido partido) {
		partido.eliminarParticipante(this)
		partido.solidarios.remove(0)
	}

	def override reemplazarSegunPrioridad(Partido partido, Participante jugador) {
		if (partido.condicionales.size != 0) {
			(partido.condicionales.get(0)).desplazarCondicional(partido)
		}
		partido.agregarParticipante(jugador)
		partido.solidarios.add(this)
	}

}
