package domainTests

import domain.calificaciones.Calificacion
import domain.criterios.CriterioCompuesto
import domain.criterios.CriterioHandicap
import domain.criterios.CriterioNCalificaciones
import domain.criterios.CriterioUltimoPartido
import domain.jugadores.Estandar
import domain.jugadores.Participante
import domain.partido.Partido
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class OrdenarParticipantesTest {
	Partido partido
	CriterioHandicap criterioHandicap
	CriterioUltimoPartido criterioUltimoPartido
	CriterioNCalificaciones criterioNCalificaciones
	CriterioCompuesto criterioCompuesto
	Participante jugador1
	Participante jugador2
	Calificacion calificacion1
	Calificacion calificacion2

	@Before
	def void beforeInscripcion() {
		partido = new Partido
		criterioHandicap = new CriterioHandicap
		criterioUltimoPartido = new CriterioUltimoPartido
		criterioCompuesto = new CriterioCompuesto
		criterioNCalificaciones = new CriterioNCalificaciones
		jugador1 = new Estandar
		jugador2 = new Estandar
		calificacion1 = new Calificacion
		calificacion2 = new Calificacion

		partido.suscribir(jugador1)
		partido.suscribir(jugador2)

		calificacion1.nota = 10
		calificacion1.descripcion = "Es una luz el pibe"
		calificacion1.fecha = "25/09/2014"

		calificacion2.nota = 1
		calificacion2.descripcion = "Horrible"
		calificacion1.fecha = "25/09/2014"

		jugador1.calificarJugador(partido, jugador2, calificacion1)
		jugador2.calificarJugador(partido, jugador1, calificacion2)

		jugador2.handicap = 1
		jugador1.handicap = 10

		criterioCompuesto.agregarCriterio(criterioUltimoPartido)
		criterioCompuesto.agregarCriterio(criterioHandicap)

		criterioNCalificaciones.cantidadCalificaciones = 1

	}

	@Test
	def ordenarListaDeParticipantesSegunPromedioUltimoPartido() {
		partido.ordenarJugadores(criterioUltimoPartido)
		Assert.assertEquals(#[jugador1, jugador2], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunHandicap() {
		partido.ordenarJugadores(criterioHandicap)
		Assert.assertEquals(#[jugador1, jugador2], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunUltimosNPartidos() {
		partido.ordenarJugadores(criterioNCalificaciones)
		Assert.assertEquals(#[jugador1, jugador2], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunCriterioCompuesto() {
		partido.ordenarJugadores(criterioCompuesto)
		Assert.assertEquals(#[jugador1, jugador2], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarSegunHandicapLuegoDeOrdenarPorUltimoPartido() {
		partido.ordenarJugadores(criterioUltimoPartido)
		partido.ordenarJugadores(criterioHandicap)
		Assert.assertEquals(#[jugador1, jugador2], partido.jugadoresOrdenados)
	}

}
