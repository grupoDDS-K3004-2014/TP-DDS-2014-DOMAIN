package domainTests

import domain.calificaciones.Calificacion
import domain.condiciones.CondicionDia
import domain.criterios.CriterioCompuesto
import domain.criterios.CriterioHandicap
import domain.criterios.CriterioNCalificaciones
import domain.criterios.CriterioUltimoPartido
import domain.jugadores.Condicional
import domain.jugadores.Estandar
import domain.jugadores.Solidario
import domain.partido.Partido
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import domain.Dia

class OrdenarParticipantesTest {
	Partido partido
	CriterioHandicap criterioHandicap
	CriterioUltimoPartido criterioUltimoPartido
	CriterioNCalificaciones criterioNCalificaciones
	CriterioCompuesto criterioCompuesto
	Estandar jugador1
	Solidario jugador2
	Condicional jugador3

	@Before
	def void beforeInscripcion() {
		partido = new Partido
		partido.dia=Dia.Lunes
		var condicion = new CondicionDia
		condicion.diaCondicion=Dia.Lunes
		criterioHandicap = new CriterioHandicap
		criterioUltimoPartido = new CriterioUltimoPartido
		criterioCompuesto = new CriterioCompuesto
		criterioNCalificaciones = new CriterioNCalificaciones
		jugador1 = new Estandar
		jugador2 = new Solidario
		jugador3 = new Condicional
		
		jugador3.agregarCondicion(condicion)

		partido.suscribir(jugador1)
		partido.suscribir(jugador2)
		partido.suscribir(jugador3)

		jugador1.calificarJugador(partido, jugador2, Calificacion.nueva(7, "Es una luz el pibe", "25/09/2014"))
		jugador2.calificarJugador(partido, jugador1, Calificacion.nueva(1, "Horrible", "25/09/2014"))

		jugador3.handicap = 5
		jugador2.handicap = 1
		jugador1.handicap = 10

		criterioCompuesto.agregarCriterio(criterioUltimoPartido)
		criterioCompuesto.agregarCriterio(criterioHandicap)

		criterioNCalificaciones.cantidadCalificaciones = 1

	}

	//jugador 1  h=10 nota=1  estandar
	//jugador 2  h=1 nota=7   solidario
	//jugador 3  h=5 nota=0  condicional
	@Test
	def ordenarListaDeParticipantesSegunHandicap() {
		partido.ordenarJugadores(criterioHandicap)
		Assert.assertEquals(#[jugador1, jugador3, jugador2], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunPromedioUltimoPartido() {
		partido.ordenarJugadores(criterioUltimoPartido)
		Assert.assertEquals(#[jugador2, jugador1, jugador3], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunUltimosNPartidos() {
		partido.ordenarJugadores(criterioNCalificaciones)
		Assert.assertEquals(#[jugador2, jugador1, jugador3], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunCriterioCompuesto() {
		partido.ordenarJugadores(criterioCompuesto)
		Assert.assertEquals(#[jugador1, jugador2, jugador3], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarSegunHandicapLuegoDeOrdenarPorUltimoPartido() {
		partido.ordenarJugadores(criterioUltimoPartido)
		partido.ordenarJugadores(criterioHandicap)
		Assert.assertEquals(#[jugador1, jugador3, jugador2], partido.jugadoresOrdenados)
	}

}
