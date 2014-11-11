package domain

import domain.jugadores.Participante
import domain.jugadores.Propuesta
import domain.jugadores.Rechazo
import java.util.HashSet
import java.util.Set

class Sistema {

	@Property Set<Propuesta> propuestas = new HashSet<Propuesta>
	@Property Set<Rechazo> rechazos = new HashSet<Rechazo>
	@Property Set<Participante> jugadoresHabilitados = new HashSet<Participante>
	@Property String fechaDelDia
	

	def aceptarPropuesta(Propuesta propuesta) {
		propuestas.remove(propuesta)
		propuesta.cargarDatos()
		jugadoresHabilitados.add(propuesta.modalidad)
	}

	def rechazarPropuesta(Propuesta propuestaRechazada, String motivo) {
		propuestas.remove(propuestaRechazada)
		var nuevoRechazo = new Rechazo
		nuevoRechazo.fecha=fechaDelDia
		nuevoRechazo.propuesta=propuestaRechazada
		nuevoRechazo.setMotivo=motivo
		rechazos.add(nuevoRechazo)

	}
	
	def agregarPropuesta(Propuesta propuesta){
		propuestas.add(propuesta)
	}



	
	


}
