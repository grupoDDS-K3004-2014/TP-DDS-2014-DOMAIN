package domainTests


import domain.condiciones.CondicionDia
import domain.condiciones.CondicionHora
import domain.condiciones.CondicionPeriodicidad
import domain.jugadores.Condicional
import domain.jugadores.Estandar
import domain.jugadores.Solidario
import domain.partido.Partido
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class InscripcionesTests {

	Partido partido = new Partido
	Estandar jugador1 = new Estandar
	Solidario juguadorSolidario = new Solidario
	Estandar jugador3 = new Estandar
	Condicional jugadorCondicional1 = new Condicional
	Condicional jugadorCondicional2 = new Condicional
	Estandar jugador6 = new Estandar
	Estandar jugador7 = new Estandar
	Estandar jugador8 = new Estandar
	Estandar jugador9 = new Estandar
	Estandar jugador10 = new Estandar
	Estandar jugador11 = new Estandar
	Estandar jugador12 = new Estandar
	Estandar jugador13 = new Estandar
	CondicionDia condicionDia = new CondicionDia
	CondicionHora condicionHora = new CondicionHora
	CondicionPeriodicidad condicionPeriodicidad = new CondicionPeriodicidad

	@Before
	def void beforeInscripcion() {

		partido.setDia("Lunes")
		partido.setHorario(1800)
		partido.setPeriodicidad(1)
		partido.setFecha("01/01/2000")

		condicionDia.setDiaCondicion("Lunes")
		condicionHora.setHoraCondicion(1800)
		condicionPeriodicidad.setPeriodicidadCondicion(1)

	}

	@Test
	def inscribirJugadorCondicionalDia() {

		jugadorCondicional1.agregarCondicion(condicionDia)
		partido.suscribir(jugadorCondicional1)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorCondicionalHora() {

		jugadorCondicional1.agregarCondicion(condicionHora)
		partido.suscribir(jugadorCondicional1)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorCondicionalPeriodicidad() {

		jugadorCondicional1.agregarCondicion(condicionPeriodicidad)
		partido.suscribir(jugadorCondicional1)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorConTresCondiciones() {

		jugadorCondicional1.agregarCondicion(condicionPeriodicidad)
		jugadorCondicional1.agregarCondicion(condicionHora)
		jugadorCondicional1.agregarCondicion(condicionDia)
		partido.suscribir(jugadorCondicional1)
		Assert.assertEquals(1, partido.cantidadParticipantes)
	}

	@Test
	def inscribirDosJugadoresConCondiciones() {

		jugadorCondicional1.agregarCondicion(condicionPeriodicidad)
		jugadorCondicional1.agregarCondicion(condicionHora)
		jugadorCondicional2.agregarCondicion(condicionDia)
		partido.suscribir(jugadorCondicional1)
		partido.suscribir(jugadorCondicional2)
		Assert.assertEquals(2, partido.cantidadParticipantes)
	}

	@Test
	def inscribirJugadorConTresCondicionesYUnaFalla() {

		partido.setPeriodicidad(2)
		jugadorCondicional1.agregarCondicion(condicionPeriodicidad)
		jugadorCondicional1.agregarCondicion(condicionHora)
		jugadorCondicional1.agregarCondicion(condicionDia)
		partido.suscribir(jugadorCondicional1)
		Assert.assertEquals(0, partido.cantidadParticipantes)
	}

	@Test
	def inscribirOnceJugadoresCuandoElMaximoEsDiezDesplazoSolidario() {
		partido.suscribir(jugador1)
		partido.suscribir(juguadorSolidario)
		partido.suscribir(jugador3)
		partido.suscribir(jugador6)
		partido.suscribir(jugador7)
		partido.suscribir(jugador8)
		partido.suscribir(jugador9)
		partido.suscribir(jugador10)
		partido.suscribir(jugador11)
		partido.suscribir(jugador12)
		partido.suscribir(jugador13)		
		Assert.assertEquals(
			#[jugador1, jugador3, jugador6, jugador7, jugador8, jugador9, jugador10, jugador11, jugador12, jugador13],
			partido.participantes)
	}

	@Test
	def inscribirEstandarDesplazSolidario() {
		jugadorCondicional1.agregarCondicion(condicionDia)
		partido.suscribir(jugador1) 
		partido.suscribir(juguadorSolidario)
		partido.suscribir(jugador3)
		partido.suscribir(jugadorCondicional1)
		partido.suscribir(jugador6)
		partido.suscribir(jugador7)
		partido.suscribir(jugador8)
		partido.suscribir(jugador9)
		partido.suscribir(jugador10)
		partido.suscribir(jugador11)
		partido.suscribir(jugador12)
		Assert.assertEquals(
			#[jugador1, jugador3, jugador6, jugador7, jugador8, jugador9, jugador10, jugador11, jugador12,jugadorCondicional1],
			partido.participantes)
	}

	@Test
	def inscribir11JugadoresCondicionalDesplazaSolidario() {

		jugadorCondicional1.agregarCondicion(condicionDia)
		
		partido.suscribir(jugadorCondicional1)
		partido.suscribir(jugador1)
		partido.suscribir(jugador3)
		partido.suscribir(jugador6)
		partido.suscribir(jugador7)
		partido.suscribir(jugador8)
		partido.suscribir(jugador9)
		partido.suscribir(jugador10)
		partido.suscribir(jugador11)
		partido.suscribir(jugador12)		
		partido.suscribir(juguadorSolidario)
		Assert.assertEquals(
			#[ jugador1, jugador3, jugador6,jugador7, jugador8, jugador9, jugador10, jugador11, jugador12,jugadorCondicional1],
			partido.participantes)
	}

}
