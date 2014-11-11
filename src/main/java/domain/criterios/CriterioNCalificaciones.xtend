package domain.criterios

import domain.jugadores.Participante
import javax.persistence.Entity

@Entity
class CriterioNCalificaciones extends Criterio {

	@Property int cantidadCalificaciones

	def static CriterioNCalificaciones nuevo(Integer cantidad) {
		var criterio = new CriterioNCalificaciones
		criterio.cantidadCalificaciones = cantidad
		criterio
	}

	override actualizarPuntajeCriterio(Participante participante) {
		participante.puntajeCriterio = participante.puntajeCriterio + participante.ultimasNotas(cantidadCalificaciones)
	}

}
