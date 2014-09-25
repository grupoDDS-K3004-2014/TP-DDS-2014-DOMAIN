package domain.jugadores

import domain.Propuesta
import domain.Sistema
import domain.calificaciones.Calificacion
import domain.infracciones.Infraccion
import domain.partido.Partido
import java.util.ArrayList
import java.util.Collection
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable

@Observable
abstract class Participante extends Entity {

	@Property Collection<Calificacion> calificaciones = new ArrayList<Calificacion>
	@Property Collection<Participante> amigos = new ArrayList<Participante>
	@Property Collection<Infraccion> infracciones = new ArrayList<Infraccion>
	@Property String nombre
	@Property String fechaNacimiento
	@Property Sistema datosDelOrganizadorDePartidos
	@Property int handicap
	@Property String apodo

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

	def Integer ultimaNota() {
		calificaciones.head.nota
	}

	def Integer ultimasNotas(int i) {

		var cantidadEfectiva = 0

		if (i > calificaciones.size)
			cantidadEfectiva = calificaciones.size
		else
			cantidadEfectiva = i
		var sumaDeCalificaciones = calificaciones.toList.subList(0, cantidadEfectiva).fold(0)[Integer total, nota|
			total + nota.nota]
		sumaDeCalificaciones / cantidadEfectiva
	}

	def void ubicarse(Partido partido) {
	}

}
