package domainTests

import domain.Sistema
import domain.jugadores.Condicional
import domain.jugadores.Estandar
import domain.jugadores.Participante
import domain.jugadores.Propuesta
import domain.partido.Partido
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class PropuestasTests {

	Participante jugador1
	Participante modalidadPropuesta
	Partido partido
	Propuesta propuesta1
	Sistema datosDelSistema

	@Before
	def void beforeInscripcion() {

		jugador1 = new Estandar
		modalidadPropuesta = new Condicional
		partido = new Partido
		propuesta1 = new Propuesta
		datosDelSistema = new Sistema

		datosDelSistema.fechaDelDia = "17/06/2014"

		

		propuesta1.setNombre("Mariano")

		propuesta1.fechaDeNacimiento = "03/02/1993"

		propuesta1.amigos.add(jugador1)
		propuesta1.setModalidad(modalidadPropuesta)

	}

	@Test
	def void proponerAUnaPersona() {
		jugador1.proponer(propuesta1,datosDelSistema)
		Assert.assertEquals(1, datosDelSistema.propuestas.size)
	}

	@Test
	def void aceptarUnaPropuesta() {
		jugador1.proponer(propuesta1,datosDelSistema)
		datosDelSistema.aceptarPropuesta(propuesta1)
		Assert.assertEquals(1, datosDelSistema.jugadoresHabilitados.size)
	}

	@Test
	def void rechazarUnaPropuesta() {
		jugador1.proponer(propuesta1,datosDelSistema)
		datosDelSistema.rechazarPropuesta(propuesta1, "Se da de baja siempre sobre la hora")
		Assert.assertEquals(1, datosDelSistema.rechazos.size)
	}

}
