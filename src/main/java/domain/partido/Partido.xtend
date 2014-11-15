package domain.partido

import domain.criterios.Criterio
import domain.infracciones.InfraccionBajaSinRemplazo
import domain.jugadores.Participante
import domain.observers.Observer
import java.io.Serializable
import java.util.ArrayList
import java.util.HashSet
import java.util.Set
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.JoinTable
import javax.persistence.ManyToMany
import org.uqbar.commons.utils.Observable
import javax.persistence.FetchType

@Entity
@Observable
class Partido implements Cloneable, Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Property long id

	@Property String nombreDelPartido
	@Property String fecha
	@Property int horario
	@Property int periodicidad
	@Property String dia
	@Property String confirmado = "No"

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="auxiliaresPorPartido", joinColumns=@JoinColumn(name="Partido_ID", referencedColumnName="_id"), inverseJoinColumns=@JoinColumn(name="Participante_ID", referencedColumnName="_id"))
	@Property Set<Participante> participantesAux = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="estandaresPorPartido", joinColumns=@JoinColumn(name="Partido_ID", referencedColumnName="_id"), inverseJoinColumns=@JoinColumn(name="Participante_ID", referencedColumnName="_id"))
	@Property Set<Participante> estandares = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="condicionalesPorPartido", joinColumns=@JoinColumn(name="Partido_ID", referencedColumnName="_id"), inverseJoinColumns=@JoinColumn(name="Participante_ID", referencedColumnName="_id"))
	@Property Set<Participante> condicionales = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="solidarioPorPartido", joinColumns=@JoinColumn(name="Partido_ID", referencedColumnName="_id"), inverseJoinColumns=@JoinColumn(name="Participante_ID", referencedColumnName="_id"))
	@Property Set<Participante> solidarios = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)	
	@Property Set<Observer> observers = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="auxiliarPorEquipoA", joinColumns=@JoinColumn(name="Partido_ID", referencedColumnName="_id"), inverseJoinColumns=@JoinColumn(name="Participante_ID", referencedColumnName="_id"))
	@Property Set<Participante> equipoA = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="auxiliarPorEquipoB", joinColumns=@JoinColumn(name="Partido_ID", referencedColumnName="_id"), inverseJoinColumns=@JoinColumn(name="Participante_ID", referencedColumnName="_id"))
	@Property Set<Participante> equipoB = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="jugadorOrdenado", joinColumns=@JoinColumn(name="Partido_ID", referencedColumnName="_id"), inverseJoinColumns=@JoinColumn(name="Participante_ID", referencedColumnName="_id"))
	@Property Set<Participante> jugadoresOrdenados = new HashSet

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
		jugadoresOrdenados = new HashSet(participantesAux.sortBy[jugador|jugador.puntajeCriterio].reverse)

	}

	def void separarJugadoresOrdenados(ArrayList<Integer> arrayDePosiciones) {

		equipoA = new HashSet
		equipoB = new HashSet
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

		/*if (cupoCerrado)
			throw new PartidoLleno
		else*/
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

	def Set<Participante> getParticipantes() {
		participantesAux = new HashSet<Participante>
		estandares.forEach[participante|participantesAux.add(participante)]
		condicionales.forEach[participante|participantesAux.add(participante)]
		solidarios.forEach[participante|participantesAux.add(participante)]
		if (participantesAux.size > 10) {
			return new HashSet<Participante>(participantesAux.toList.subList(0, 10))
		} else
			return new HashSet<Participante>(participantesAux)
	}

	def setParticipantes(Set<Participante> p) {
	}

	def confirmarDesconfirmarPartido() {

		if (confirmado == "Si")
			confirmado = "No"
		else
			confirmado = "Si"
	}

}
