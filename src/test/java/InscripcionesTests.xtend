import org.junit.Assert
import org.junit.Before
import org.junit.Test

class InscripcionesTests {

	Partido partido = new Partido
	Participante jugador1 = new Estandar
	Participante jugador2 = new Solidario
	Participante jugador3 = new Estandar
	Participante jugador4 = new Condicional
	Participante jugador5 = new Condicional
	Participante jugador6 = new Estandar
	Participante jugador7 = new Estandar
	Participante jugador8 = new Estandar
	Participante jugador9 = new Estandar
	Participante jugador10 = new Estandar
	Participante jugador11 = new Estandar
	Participante jugador12 = new Estandar
	Participante jugador13 = new Estandar
	CondicionDia condicionDia = new CondicionDia
	CondicionHora condicionHora = new CondicionHora
	CondicionPeriodicidad condicionPeriodicidad = new CondicionPeriodicidad

	@Before
	def void beforeInscripcion() {

		partido.setDia(Dia.Lunes)
		partido.setHorario(18)
		partido.setPeriodicidad(1)
		partido.setFecha(01012000)

		condicionDia.setDiaCondicion(Dia.Lunes)
		condicionHora.setHoraCondicion(18)
		condicionPeriodicidad.setPeriodicidadCondicion(1)

	}

	@Test
	def inscribirJugadorCondicionalDia() {

		jugador4.agregarCondicion(condicionDia)
		partido.suscribir(jugador4)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorCondicionalHora() {

		jugador4.agregarCondicion(condicionHora)
		partido.suscribir(jugador4)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorCondicionalPeriodicidad() {

		jugador4.agregarCondicion(condicionPeriodicidad)
		partido.suscribir(jugador4)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorConTresCondiciones() {

		jugador4.agregarCondicion(condicionPeriodicidad)
		jugador4.agregarCondicion(condicionHora)
		jugador4.agregarCondicion(condicionDia)
		partido.suscribir(jugador4)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirDosJugadoresConCondiciones() {

		jugador4.agregarCondicion(condicionPeriodicidad)
		jugador4.agregarCondicion(condicionHora)
		jugador5.agregarCondicion(condicionDia)
		partido.suscribir(jugador4)
		partido.suscribir(jugador5)
		Assert.assertEquals(2, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorConTresCondicionesYUnaFalla() {

		partido.setPeriodicidad(2)
		jugador4.agregarCondicion(condicionPeriodicidad)
		jugador4.agregarCondicion(condicionHora)
		jugador4.agregarCondicion(condicionDia)
		partido.suscribir(jugador4)
		Assert.assertEquals(0, partido.cantidadParticipantes)
	}

	@Test
	def inscribirOnceJugadoresCuandoElMaximoEsDiezDesplazoSolidario() {
		partido.suscribir(jugador1)
		partido.suscribir(jugador2)
		partido.suscribir(jugador3)
		partido.suscribir(jugador6)
		partido.suscribir(jugador7)
		partido.suscribir(jugador8)
		partido.suscribir(jugador9)
		partido.suscribir(jugador10)
		partido.suscribir(jugador11)
		partido.suscribir(jugador12)
		partido.suscribir(jugador13)
		Assert.assertArrayEquals(
			#[jugador1, jugador3, jugador6, jugador7, jugador8, jugador9, jugador10, jugador11, jugador12, jugador13],
			partido.participantes)
	}

	@Test
	def inscribirTresJugadoresCuandoElMaximoEsDosEljugadorAinscribiresEstandarDesplazoCondicional() {
		jugador4.agregarCondicion(condicionDia)
		partido.suscribir(jugador1)
		partido.suscribir(jugador2)
		partido.suscribir(jugador4)
		partido.suscribir(jugador3)
		partido.suscribir(jugador6)
		partido.suscribir(jugador7)
		partido.suscribir(jugador8)
		partido.suscribir(jugador9)
		partido.suscribir(jugador10)
		partido.suscribir(jugador11)
		partido.suscribir(jugador12)
		Assert.assertArrayEquals(
			#[jugador1, jugador2, jugador3, jugador6, jugador7, jugador8, jugador9, jugador10, jugador11, jugador12],
			partido.participantes)
	}

	@Test
	def inscribirTresJugadoresCuandoElMaximoEsDosEljugadorAinscribiresSolidarioDesplazoCondicional() {

		jugador4.agregarCondicion(condicionDia)
		partido.suscribir(jugador4)
		partido.suscribir(jugador1)
		partido.suscribir(jugador3)
		partido.suscribir(jugador6)
		partido.suscribir(jugador7)
		partido.suscribir(jugador8)
		partido.suscribir(jugador9)
		partido.suscribir(jugador10)
		partido.suscribir(jugador11)
		partido.suscribir(jugador12)
		partido.suscribir(jugador2)
		Assert.assertArrayEquals(
			#[jugador1, jugador3, jugador6, jugador7, jugador8, jugador9, jugador10, jugador11, jugador12, jugador2],
			partido.participantes)
	}

}
