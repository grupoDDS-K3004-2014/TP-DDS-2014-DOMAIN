package domain.jugadores

import domain.Sistema
import domain.calificaciones.Calificacion
import domain.criterios.Criterio
import domain.exceptions.CalificacionIncorrectaException
import domain.exceptions.NotaCalificacionIncorrecta
import domain.infracciones.Infraccion
import domain.partido.Partido
import java.io.Serializable
import java.util.HashSet
import java.util.Set
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import org.uqbar.commons.utils.Observable
import javax.persistence.FetchType

@Observable
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
class Participante implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Property long id

	@OneToMany(fetch=FetchType.EAGER)
	@Property Set<Calificacion> calificaciones = new HashSet

	@ManyToMany(fetch=FetchType.EAGER)
	@Property Set<Participante> amigos = new HashSet

	@OneToMany(fetch=FetchType.EAGER)
	@Property Set<Infraccion> infracciones = new HashSet

	@Property String nombre
	@Property String fechaNacimiento
	@Property int handicap
	@Property int puntajeCriterio
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
