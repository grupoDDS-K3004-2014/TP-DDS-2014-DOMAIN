import java.util.List
import java.util.ArrayList
import java.util.Collections

class Sistema {

	@Property List<Propuesta> propuestas = new ArrayList<Propuesta>
	@Property List<Rechazo> rechazos = new ArrayList<Rechazo>
	@Property List<Participante> jugadoresHabilitados = new ArrayList<Participante>
	@Property long fechaDelDia
	

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
		partido.jugadoresOrdenados= partido.participantes
		partido.jugadoresOrdenados.forEach[Participante participante|participante.puntajesCriterio = new ArrayList<Integer>]
		partido.jugadoresOrdenados.forEach[Participante participante|criterio.determinarPuntajeCriterio(participante)]
		Collections.sort(partido.jugadoresOrdenados, new Comparador)
	}

	def generarEquiposTentativos(DivisionEquipos algoritmoDivision,Partido partido, List<Integer> posicionesDeUnEquipo) {
		algoritmoDivision.distribuirEquipos(partido.jugadoresOrdenados, posicionesDeUnEquipo)
	}

	def confirmarEquipos(DivisionEquipos algoritmoDivision, Partido partido) {
		partido.setEquipoA(algoritmoDivision.jugadoresEquipoA)
		partido.setEquipoB(algoritmoDivision.jugadoresEquipoB)
		
	}

}
