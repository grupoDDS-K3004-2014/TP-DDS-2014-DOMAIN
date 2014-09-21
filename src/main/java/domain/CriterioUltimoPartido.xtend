package domain

class CriterioUltimoPartido implements Criterio {

	override void determinarPuntajeCriterio(Participante participante) {

		var listaDeUltimosPartidos = participante.calificaciones.filter[Calificacion calificacion|
			calificacion.getFecha ==
				((participante.getCalificaciones).get(participante.calificaciones.size - 1)).getFecha]

		var totalDeCalificaciones = listaDeUltimosPartidos.fold(0)[totalCalificaciones, calificacion|
			totalCalificaciones + calificacion.getNota]

		if (!(participante.calificaciones.isEmpty))
			participante.puntajesCriterio.add(totalDeCalificaciones / participante.calificaciones.size)
		else {
			participante.puntajesCriterio.add(0)
		}

	}

}
