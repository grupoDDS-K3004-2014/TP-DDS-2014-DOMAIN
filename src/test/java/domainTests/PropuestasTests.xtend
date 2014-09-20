package domainTests
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import domain.Condicional
import domain.Participante
import domain.Partido
import domain.Propuesta
import domain.Sistema
import domain.Estandar

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

		datosDelSistema.fechaDelDia = 17062014

		jugador1.datosDelOrganizadorDePartidos = datosDelSistema

		propuesta1.setNombre("Mariano")
		propuesta1.fechaDeNacimiento = 321993
		propuesta1.amigos.add(jugador1)
		propuesta1.setModalidad(modalidadPropuesta)

	}

	@Test
	def void proponerAUnaPersona() {
		jugador1.proponer(propuesta1)
		Assert.assertEquals(1, datosDelSistema.propuestas.size)
	}

	@Test
	def void aceptarUnaPropuesta() {
		jugador1.proponer(propuesta1)
		datosDelSistema.aceptarPropuesta(propuesta1)
		Assert.assertEquals(1, datosDelSistema.jugadoresHabilitados.size)
	}

	@Test
	def void rechazarUnaPropuesta() {
		jugador1.proponer(propuesta1)
		datosDelSistema.rechazarPropuesta(propuesta1, "Se da de baja siempre sobre la hora")
		Assert.assertEquals(1, datosDelSistema.rechazos.size)
	}

}
