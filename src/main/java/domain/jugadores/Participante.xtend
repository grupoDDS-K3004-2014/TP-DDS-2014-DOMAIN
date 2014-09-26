package domain.jugadores

import domain.Sistema
import domain.calificaciones.Calificacion
import domain.infracciones.Infraccion
import domain.partido.Partido
import java.util.ArrayList
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import domain.exceptions.CalificacionIncorrectaException
import domain.exceptions.NotaCalificacionIncorrecta
import domain.criterios.Criterio

@Observable
class Participante extends Entity {

	@Property ArrayList<Calificacion> calificaciones = new ArrayList<Calificacion>
	@Property ArrayList<Participante> amigos = new ArrayList<Participante>
	@Property ArrayList<Infraccion> infracciones = new ArrayList<Infraccion>
	@Property String nombre
	@Property String fechaNacimiento
	@Property int handicap
	@Property Integer puntajeCriterio
	@Property String apodo

	def agregarInfraccion(Infraccion infraccion) {
		infracciones.add(infraccion)
	}

	def agregarAmigo(Participante amigo) {
		amigos.add(amigo)
	}

	def calificarJugador(Partido partido, Participante jugador, Calificacion calificacion) {
		validarCalificacion(calificacion)
		if (partido.participantes.contains(this) && partido.participantes.contains(jugador)) {
			jugador.calificaciones.add(calificacion)
		} else
			throw new CalificacionIncorrectaException
	}

	def void validarCalificacion(Calificacion calificacion) {
		if (0 > calificacion.nota || calificacion.nota > 10)
			throw new NotaCalificacionIncorrecta
	}

	def proponer(Propuesta propuesta, Sistema datosDelOrganizadorDePartidos) {
		datosDelOrganizadorDePartidos.agregarPropuesta(propuesta)
	}

	def Integer ultimaNota() {
		if (calificaciones.empty)
			0
		else
			calificaciones.head.nota
	}

	def Integer ultimasNotas(int i) {

		if (calificaciones.empty)
			return 0
		var cantidadEfectiva = 0
		if (i > calificaciones.size)
			cantidadEfectiva = calificaciones.size
		else
			cantidadEfectiva = i
		var sumaDeCalificaciones = calificaciones.toList.subList(0, cantidadEfectiva).fold(0)[Integer total, nota|
			total + nota.nota]
		return sumaDeCalificaciones / cantidadEfectiva

	}

	def void ubicarse(Partido partido) {
	}

	def calcularPuntajeCriterio(Criterio criterio) {

		criterio.actualizarPuntajeCriterio(this)
	}

}