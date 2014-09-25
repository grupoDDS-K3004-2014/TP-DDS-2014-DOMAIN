package domain.partido

import domain.Dia
import domain.criterios.Criterio
import domain.exceptions.PartidoLleno
import domain.infracciones.InfraccionBajaSinRemplazo
import domain.jugadores.Participante
import java.util.ArrayList
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import domain.observers.Observer

@Observable
class Partido extends Entity implements Cloneable {

	@Property int periodicidad
	@Property Dia dia
	@Property int horario
	@Property String fecha
	ArrayList<Participante> participantesAux = new ArrayList<Participante>
	@Property ArrayList<Participante> estandares = new ArrayList
	@Property ArrayList<Participante> condicionales = new ArrayList
	@Property ArrayList<Participante> solidarios = new ArrayList
	@Property ArrayList<Observer> observers = new ArrayList
	@Property ArrayList<Participante> equipoA = new ArrayList
	@Property ArrayList<Participante> equipoB = new ArrayList
	@Property ArrayList<Participante> jugadoresOrdenados = new ArrayList
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
		criterio.determinarPuntajeJugadores(this)
		jugadoresOrdenados.forEach[jugador| jugador.puntajeCriterio = 0]
		jugadoresOrdenados = new ArrayList(jugadoresOrdenados.sortBy[jugador|jugador.puntajeCriterio])
	}

	def separarJugadoresOrdenados(ArrayList<Integer> arrayDePosiciones) {

		equipoA = new ArrayList
		equipoB = new ArrayList
		arrayDePosiciones.map[posicion|posicion - 1].forEach[posicion|equipoA.add(jugadoresOrdenados.get(posicion))]
		equipoB.addAll(jugadoresOrdenados.filter[jugadores|!(equipoA.contains(jugadores))])
	}

	def void confirmarDesconfirmarPartido() {
		if (confirmado == "No")
			confirmado = "Si"
		else
			confirmado = "No"
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
