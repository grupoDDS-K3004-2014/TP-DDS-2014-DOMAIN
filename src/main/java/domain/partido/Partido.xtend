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

	@Property String nombreDelPartido
	@Property String fecha
	@Property int horario
	@Property int periodicidad
	@Property Dia dia
	@Property String confirmado = "No"
	ArrayList<Participante> participantesAux = new ArrayList<Participante>
	@Property ArrayList<Participante> estandares = new ArrayList
	@Property ArrayList<Participante> condicionales = new ArrayList
	@Property ArrayList<Participante> solidarios = new ArrayList
	@Property ArrayList<Observer> observers = new ArrayList
	@Property ArrayList<Participante> equipoA = new ArrayList
	@Property ArrayList<Participante> equipoB = new ArrayList
	@Property ArrayList<Participante> jugadoresOrdenados = new ArrayList

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

	def ordenarJugadores(Criterio criterio) {

		participantesAux = getParticipantes
		participantesAux.forEach[jugador|jugador.setPuntajeCriterio(0)]
		participantesAux.forEach(
			[criterioOrdenamiento, Participante jugador|jugador.calcularPuntajeCriterio(criterioOrdenamiento)].
				curry(criterio))
		jugadoresOrdenados = new ArrayList(participantesAux.sortBy[jugador|jugador.puntajeCriterio].reverse)

	}

	def void separarJugadoresOrdenados(ArrayList<Integer> arrayDePosiciones) {

		equipoA = new ArrayList
		equipoB = new ArrayList
		arrayDePosiciones.map[posicion|posicion - 1].forEach[posicion|equipoA.add(jugadoresOrdenados.get(posicion))]
		equipoB.addAll(jugadoresOrdenados.filter[jugadores|!(equipoA.contains(jugadores))])

	}

	def int cantidadParticipantes() {
		return getParticipantes.size
	}

	def eliminarParticipante(Participante jugador) {
		estandares.remove(jugador)
		condicionales.remove(jugador)
		solidarios.remove(jugador)
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
		eliminarParticipante(participanteADarDeBaja)
		val infraccion = InfraccionBajaSinRemplazo.nueva(fecha, "")
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

	def confirmarDesconfirmarPartido() {

		if (confirmado == "Si")
			confirmado = "No"
		else
			confirmado = "Si"
	}

}
