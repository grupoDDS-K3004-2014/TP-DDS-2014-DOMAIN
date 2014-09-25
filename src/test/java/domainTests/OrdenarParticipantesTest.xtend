package domainTests

import domain.calificaciones.Calificacion
import domain.criterios.Criterio
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
import java.util.ArrayList

class OrdenarParticipantesTest {
	Partido partido
	Criterio criterioHandicap
	Criterio criterioUltimoPartido
	CriterioNCalificaciones criterioNCalificaciones
	CriterioCompuesto criterioCompuesto
	Participante jugador1
	Participante jugador2
	Calificacion calificacion1
	Calificacion calificacion2
	ArrayList<Integer> a

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

		//criterioNCalificaciones.cantidadPartidos=1
		partido.suscribir(jugador1)
		partido.suscribir(jugador2)

		calificacion1.nota = 10
		calificacion1.descripcion = "Es una luz el pibe"
		calificacion1.fecha = "25/09/2014"

		calificacion2.nota = 2
		calificacion2.descripcion = "Horrible"
		calificacion1.fecha = "25/09/2014"

		jugador1.calificarJugador(partido, jugador2, calificacion1)
		jugador2.calificarJugador(partido, jugador1, calificacion2)

		jugador2.handicap = 3
		jugador1.handicap = 1

		criterioCompuesto.criterios.add(criterioUltimoPartido)

		criterioNCalificaciones.cantidadCalificaciones = 1

		a = new ArrayList<Integer>
	}

	@Test
	def ordenarListaDeParticipantesSegunPromedioUltimoPartido() {
		partido.ordenarJugadores(criterioUltimoPartido)
		Assert.assertEquals(#[jugador2, jugador1], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunHandicap() {
		partido.ordenarJugadores(criterioHandicap)
		Assert.assertEquals(#[jugador2, jugador1], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunUltimosNPartidos() {
		partido.ordenarJugadores(criterioNCalificaciones)
		Assert.assertEquals(#[jugador2, jugador1], partido.jugadoresOrdenados)
	}

	@Test
	def ordenarListaDeParticipantesSegunCriterioCompuesto() {
		partido.ordenarJugadores(criterioCompuesto)
		Assert.assertEquals(#[jugador2, jugador1], partido.jugadoresOrdenados)
	}

}
