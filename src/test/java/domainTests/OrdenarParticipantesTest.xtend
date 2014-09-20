package domainTests

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import domain.Partido
import domain.Criterio
import domain.CriterioNCalificaciones
import domain.Participante
import domain.Calificacion
import domain.CriterioCompuesto
import domain.Sistema
import domain.CriterioHandicap
import domain.CriterioUltimoPartido
import domain.Estandar

class OrdenarParticipantesTest {
	Partido partido1
	Criterio handicap1
	Criterio criterioPromedio
	CriterioNCalificaciones criterioNCalificaciones
	CriterioCompuesto criterioCompuesto
	Participante jugador1
	Participante jugador2
	Sistema sistema
	Calificacion calificacion1
	Calificacion calificacion2

	@Before
	def void beforeInscripcion() {
		partido1 = new Partido
		handicap1 = new CriterioHandicap
		criterioPromedio = new CriterioUltimoPartido
		criterioCompuesto = new CriterioCompuesto
		criterioNCalificaciones = new CriterioNCalificaciones
		jugador1 = new Estandar
		jugador2 = new Estandar
		sistema = new Sistema
		calificacion1 = new Calificacion
		calificacion2 = new Calificacion

		//criterioNCalificaciones.cantidadPartidos=1
		partido1.suscribir(jugador1)
		partido1.suscribir(jugador2)

		calificacion1.nota = 10
		calificacion1.descripcion = "master"
		calificacion1.fecha = 0000

		calificacion2.nota = 2
		calificacion2.descripcion = "lo que sea"
		calificacion1.fecha = 0000

		jugador1.calificarJugador(partido1, jugador2, calificacion1)
		jugador2.calificarJugador(partido1, jugador1, calificacion2)

		jugador2.handicap = 3
		jugador1.handicap = 1

		criterioCompuesto.criterios.add(criterioPromedio)

		criterioNCalificaciones.cantidadCalificaciones = 1

	}

	@Test
	def ordenarListaDeParticipantesSegunPromedioUltimoPartido() {
		sistema.organizarJugadoresPorCriterio(criterioPromedio, partido1)
		Assert.assertArrayEquals(#[jugador2, jugador1], partido1.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunHandicapTest() {
		sistema.organizarJugadoresPorCriterio(handicap1, partido1)
		Assert.assertArrayEquals(#[jugador2, jugador1], partido1.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunUltimosNPartidos() {
		sistema.organizarJugadoresPorCriterio(criterioNCalificaciones, partido1)
		Assert.assertArrayEquals(#[jugador2, jugador1], partido1.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunCriterioCompuesto() {
		sistema.organizarJugadoresPorCriterio(criterioCompuesto, partido1)
		Assert.assertArrayEquals(#[jugador2, jugador1], partido1.jugadoresOrdenados)
	}
}
