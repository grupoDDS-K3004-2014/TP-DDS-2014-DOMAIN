package domain.partido

import domain.Dia
import domain.Observer
import domain.criterios.Criterio
import domain.exceptions.PartidoLleno
import domain.infracciones.InfraccionBajaSinRemplazo
import domain.jugadores.Participante
import java.util.ArrayList
import java.util.Collection
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable

@Observable
class Partido extends Entity implements Cloneable {

	@Property int periodicidad
	@Property Dia dia
	@Property int horario
	@Property String fecha
	Collection<Participante> participantesAux = new ArrayList<Participante>
	@Property Collection<Participante> estandares = new ArrayList
	@Property Collection<Participante> condicionales = new ArrayList
	@Property Collection<Participante> solidarios = new ArrayList
	@Property Collection<Observer> observers = new ArrayList
	@Property Collection<Participante> equipoA = new ArrayList
	@Property Collection<Participante> equipoB = new ArrayList
	@Property Collection<Participante> jugadoresOrdenados = new ArrayList
	@Property String confirmado = "No"
	@Property String nombreDelPartido

	def void copiarValoresDe(Partido partido) {
		periodicidad = partido.periodicidad
		dia = partido.dia
		horario = partido.horario
		fecha = partido.fecha
		participantes = partido.participantes
		observers = partido.observers
		equipoA = partido.equipoA
		equipoB = partido.equipoB
		jugadoresOrdenados = partido.jugadoresOrdenados

	}

	override clone() {
		super.clone()
	}

	def void ordenarJugadores(Criterio criterio) {
		jugadoresOrdenados = participantes
		jugadoresOrdenados.sortBy(criterio.devolverCriterio(this))
	}

	
	def int cantidadParticipantes() {
		return getParticipantes.size
	}

	def eliminarParticipante(Participante jugador) {
		participantes.remove(jugador)
	}

	def suscribir(Participante jugador) {
		if (cupoCerrado)
			throw new PartidoLleno
		else
			jugador.ubicarse(this)

	}

	def cupoCerrado() {
		estandares.size > 10

	}

	def notificarAltaObservers(Participante observable) {
		observers.forEach[Observer observer|observer.notificarAlta(observable)]
	}

	def notificarBajaObservers() {
		observers.forEach[Observer observer|observer.notificarBaja]
	}

	def observerAdd(Observer observer) {
		observers.add(observer)
	}

	def darDeBaja(Participante participanteADarDeBaja, Participante participanteADarDeAlta) {
		notificarBajaObservers()
		this.eliminarParticipante(participanteADarDeBaja)
		suscribir(participanteADarDeAlta)
		notificarAltaObservers(participanteADarDeAlta)

	}

	def darDeBaja(Participante participanteADarDeBaja) {
		notificarBajaObservers()
		this.eliminarParticipante(participanteADarDeBaja)
		val infraccion = new InfraccionBajaSinRemplazo
		infraccion.fecha = fecha
		participanteADarDeBaja.agregarInfraccion(infraccion)
	}

	def ArrayList<Participante> getParticipantes() {
		participantesAux = new ArrayList<Participante>
		estandares.forEach[participante|participantesAux.add(participante)]
		condicionales.forEach[participante|participantesAux.add(participante)]
		solidarios.forEach[participante|participantesAux.add(participante)]
		if (participantesAux.size > 10) {
			return new ArrayList<Participante>(participantesAux.toList.subList(0, 10))
		} else
			return new ArrayList<Participante>(participantesAux)
	}

	def setParticipantes(ArrayList<Participante> p) {
	}
}
