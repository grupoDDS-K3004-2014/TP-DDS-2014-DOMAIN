package domain

import java.util.ArrayList
import java.util.Collections
import java.util.List
import org.eclipse.xtend.lib.Property

class Sistema {

	@Property List<Propuesta> propuestas = new ArrayList<Propuesta>
	@Property List<Rechazo> rechazos = new ArrayList<Rechazo>
	@Property List<Participante> jugadoresHabilitados = new ArrayList<Participante>
	@Property long fechaDelDia
	@Property ArrayList<Participante> equipoA = new ArrayList
	@Property ArrayList<Participante> equipoB = new ArrayList

	def aceptarPropuesta(Propuesta propuesta) {
		propuestas.remove(propuesta)
		propuesta.cargarDatos()
		jugadoresHabilitados.add(propuesta.modalidad)
	}

	def rechazarPropuesta(Propuesta propuestaRechazada, String motivo) {
		propuestas.remove(propuestaRechazada)
		var nuevoRechazo = new Rechazo
		nuevoRechazo.setFecha(fechaDelDia)
		nuevoRechazo.setPropuesta(propuestaRechazada)
		nuevoRechazo.setMotivo(motivo)
		rechazos.add(nuevoRechazo)

	}

	def organizarJugadoresPorCriterio(Criterio criterio, Partido partido) {
		var jugadoresOrdenados = new ArrayList<Participante>
		jugadoresOrdenados = partido.participantes
		jugadoresOrdenados.forEach[Participante participante|participante.puntajesCriterio = new ArrayList<Integer>]
		jugadoresOrdenados.forEach[Participante participante|criterio.determinarPuntajeCriterio(participante)]
		Collections.sort(jugadoresOrdenados, new Comparador)
		partido.jugadoresOrdenados = jugadoresOrdenados
	}

	def generarEquiposTentativos(Partido partido, ArrayList<Integer> posicionesDeUnEquipo) {
		equipoA = new ArrayList<Participante>
		equipoB = new ArrayList<Participante>

		partido.jugadoresOrdenados.forEach[jugadorOrdenado|
			if(posicionesDeUnEquipo.map[numero|numero - 1].contains(partido.jugadoresOrdenados.indexOf(jugadorOrdenado))) equipoA.
				add(jugadorOrdenado) else equipoB.add(jugadorOrdenado)]

	}

	def confirmarEquipos(Partido partido) {
		partido.equipoA = equipoA
		partido.equipoB = equipoB
	}

}
