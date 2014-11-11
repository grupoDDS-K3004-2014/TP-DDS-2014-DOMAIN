package domain.jugadores

import domain.condiciones.Condicion
import domain.partido.Partido
import java.util.HashSet
import java.util.Set
import javax.persistence.OneToMany
import javax.persistence.Entity

@Entity
class Condicional extends Participante {

	@OneToMany
	@Property Set<Condicion> condiciones = new HashSet<Condicion>

	def condicionesCumplidas(Partido partido) {

		condiciones.forall[Condicion condicion|condicion.verificarCondicion(partido)]

	}

	def agregarCondicion(Condicion condicion) {
		condiciones.add(condicion)
	}

	override ubicarse(Partido partido) {
		if (condicionesCumplidas(partido)) {
			partido.condicionales.add(this)
			partido.notificarAltaObservers(this)
		}

	}
}
