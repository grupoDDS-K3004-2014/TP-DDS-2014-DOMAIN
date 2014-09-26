package domain

import domain.jugadores.Participante
import domain.jugadores.Propuesta
import domain.jugadores.Rechazo
import java.util.ArrayList

class Sistema {

	@Property ArrayList<Propuesta> propuestas = new ArrayList<Propuesta>
	@Property ArrayList<Rechazo> rechazos = new ArrayList<Rechazo>
	@Property ArrayList<Participante> jugadoresHabilitados = new ArrayList<Participante>
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
