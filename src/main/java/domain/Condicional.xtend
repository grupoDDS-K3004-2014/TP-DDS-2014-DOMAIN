package domain
import java.util.ArrayList
import java.util.List

class Condicional extends Participante {

	List<Condicion> condiciones = new ArrayList<Condicion>

	override inscripcion(Partido partido) {

		if (partido.cantidadParticipantes < 10 && this.condicionesCumplidas(partido)) {
			partido.agregarParticipante(this)
			partido.agregarCondicional(this)
		} else {
		}
	}

	def desplazarCondicional(Partido partido) {
		partido.eliminarParticipante(partido.condicionales.get(0))
		partido.condicionales.remove(0)
	}

	override agregarCondicion(Condicion condicionNueva) {
		condiciones.add(condicionNueva)

	}

	def condicionesCumplidas(Partido partido) {

		condiciones.forall[Condicion condicion|condicion.verificarCondicion(partido)]

	}
}
