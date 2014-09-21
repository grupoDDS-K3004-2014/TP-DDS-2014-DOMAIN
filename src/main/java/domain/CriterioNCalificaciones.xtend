package domain

class CriterioNCalificaciones implements Criterio {

	@Property int cantidadCalificaciones

	override void determinarPuntajeCriterio(Participante participante) {
		val invertidos = participante.calificaciones.reverse
		val invertidosFiltrados = invertidos.filter[Calificacion calificacion|
			calificacion.getFecha == (invertidos.get(0)).getFecha]
		val listaDeCalificacions = invertidosFiltrados.take(cantidadCalificaciones)
		val listaDeNotas = listaDeCalificacions.map[Calificacion calificacion|calificacion.getNota]
		val notaTotal = listaDeNotas.fold(0)[total, nota|total + nota]

		if (!(listaDeCalificacions.isEmpty))
			participante.puntajesCriterio.add(notaTotal / participante.calificaciones.size)
		else {
			participante.puntajesCriterio.add(0)
		}
	}
}
