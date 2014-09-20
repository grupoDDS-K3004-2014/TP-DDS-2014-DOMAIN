package domain
import java.util.ArrayList
import java.util.List

class Partido {

	@Property int periodicidad
	@Property Dia dia
	@Property int horario
	@Property int fecha
	ArrayList<Participante> participantes = new ArrayList<Participante>
	List<Solidario> solidarios = new ArrayList<Solidario>
	List<Condicional> condicionales = new ArrayList<Condicional>
	List<Observer> observers = new ArrayList<Observer>
	@Property List<Participante> equipoA = new ArrayList<Participante>
	@Property List<Participante> equipoB = new ArrayList<Participante>
	@Property ArrayList<Participante> jugadoresOrdenados = new ArrayList<Participante>

	new() {

		participantes = new ArrayList<Participante>
		solidarios = new ArrayList<Solidario>
		condicionales = new ArrayList<Condicional>
		observers = new ArrayList<Observer>
	}

	def int cantidadParticipantes() {
		return participantes.size
	}

	def participantes() {
		return participantes
	}

	def solidarios() {
		return solidarios
	}

	def condicionales() {
		return condicionales
	}

	def eliminarParticipante(Participante jugador) {
		participantes.remove(jugador)
	}

	def agregarParticipante(Participante jugador) {
		this.notificarAltaObservers(jugador)
		participantes.add(jugador)

	}

	def agregarSolidario(Solidario jugador) {
		solidarios.add(jugador)
	}

	def agregarCondicional(Condicional jugador) {
		condicionales.add(jugador)
	}

	def suscribir(Participante jugador) {
		jugador.inscripcion(this)
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
		agregarParticipante(participanteADarDeAlta)
		notificarAltaObservers(participanteADarDeAlta)

	}

	def darDeBaja(Participante participanteADarDeBaja) {
		notificarBajaObservers()
		this.eliminarParticipante(participanteADarDeBaja)
		val infraccion = new InfraccionBajaSinRemplazo
		infraccion.setFecha(fecha)
		participanteADarDeBaja.agregarInfraccion(infraccion)
	}

// aca no tiene que ir lo del command
}