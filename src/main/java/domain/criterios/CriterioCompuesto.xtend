package domain.criterios

import domain.jugadores.Participante
import java.util.HashSet
import java.util.Set
import javax.persistence.Entity
import javax.persistence.OneToMany

@Entity
class CriterioCompuesto extends Criterio {

	@OneToMany
	@Property Set<Criterio> criterios = new HashSet<Criterio>

	def agregarCriterio(Criterio criterio) {
		criterios.add(criterio)
	}

	override actualizarPuntajeCriterio(Participante participante2) {

		criterios.forEach[criterio|criterio.actualizarPuntajeCriterio(participante2)]
	}

}
