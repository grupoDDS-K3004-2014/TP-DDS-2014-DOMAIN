package domain

import java.util.ArrayList
import java.util.List
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.Entity
import java.util.Date

@Observable
class Participante extends Entity {

	@Property List<Calificacion> calificaciones = new ArrayList<Calificacion>
	@Property ArrayList<Participante> amigos = new ArrayList<Participante>
	@Property List<Infraccion> infracciones = new ArrayList<Infraccion>
	@Property String nombre
	@Property Date fechaNacimiento
	@Property Sistema datosDelOrganizadorDePartidos
	@Property ArrayList<Integer> puntajesCriterio = new ArrayList
	@Property int handicap
	@Property String apodo
	@Property long promedio

	def serDezplazadoSolidario(Partido partido) {
	}

	def serDezplazadoCondicional(Partido partido) {
	}

	def reemplazarSegunPrioridad(Partido partido, Participante jugador) {
	}

	def void inscripcion(Partido partido) {
	}

	def agregarCondicion(Condicion condicion) {
	}

	def agregarInfraccion(Infraccion infraccion) {
		infracciones.add(infraccion)
	}

	def agregarAmigo(Participante amigo) {
		amigos.add(amigo)
	}

	def calificarJugador(Partido partido, Participante jugador, Calificacion calificacion) {
		if (partido.participantes.contains(this) && partido.participantes.contains(jugador) && calificacion.nota >= 1 &&
			calificacion.nota <= 10) {
			jugador.calificaciones.add(calificacion)
		}
	}

	def proponer(Propuesta propuesta) {
		datosDelOrganizadorDePartidos.propuestas.add(propuesta)
	}

}
