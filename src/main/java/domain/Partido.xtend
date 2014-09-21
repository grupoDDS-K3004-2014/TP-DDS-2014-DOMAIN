package domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.Property
import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Observable
class Partido extends Entity implements Cloneable{

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
	@Property String nombreDelPartido
	@Property String confirmado = "No"

	new() {

		participantes = new ArrayList<Participante>
		solidarios = new ArrayList<Solidario>
		condicionales = new ArrayList<Condicional>
		observers = new ArrayList<Observer>
	}
	
	def void copiarValoresDe(Partido partido){
		periodicidad = partido.periodicidad
		dia = partido.dia
		horario = partido.horario
		fecha = partido.fecha
		participantes = partido.participantes
		solidarios = partido.solidarios
		condicionales = partido.condicionales
		observers = partido.observers
		equipoA = partido.equipoA
		equipoB = partido.equipoB
		jugadoresOrdenados = partido.jugadoresOrdenados
		confirmado = partido.confirmado
		}
	
	override clone() {
		super.clone()
	}

	def confirmarPartido() {
		validarConfirmacion
		if(confirmado == "No") confirmado = "Si" else confirmado = "No"
	}

	def validarConfirmacion() {
		if (this.noOrganizado) {
			throw new UserException("El equipo no está organizado")
		}
	}

	def boolean noOrganizado() {
		equipoA.isEmpty && equipoB.isEmpty

	}

	def int cantidadInscriptos() {
		participantes.size + solidarios.size + condicionales.size
	}

	def Partido setValores(int periodicidad2, Dia dia2, int horario2, int fecha2, String nombreDelPartido2) {
		periodicidad = periodicidad2
		dia = dia2
		horario = horario2
		fecha = fecha2
		nombreDelPartido = nombreDelPartido2
		return this
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

}
