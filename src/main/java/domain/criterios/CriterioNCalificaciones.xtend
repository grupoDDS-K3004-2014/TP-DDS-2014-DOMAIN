package domain.criterios

import domain.jugadores.Participante

class CriterioNCalificaciones implements Criterio {

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
