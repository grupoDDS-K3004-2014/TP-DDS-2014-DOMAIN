import org.junit.Assert
import org.junit.Before
import org.junit.Test

class InfraccionesTests {
	Partido partido = new Partido
	Participante jugador4 = new Condicional

	@Before
	def void beforeInscripcion() {

		partido.setDia(Dia.Lunes)
		partido.setHorario(18)
		partido.setPeriodicidad(1)
		partido.setFecha(01012000)

	}

	@Test
	def inscribirJugadorYDarDeBaja() {

		partido.suscribir(jugador4)
		partido.darDeBaja(jugador4)
		val cantidadInfracciones = jugador4.getInfracciones.size()
		Assert.assertEquals(1, cantidadInfracciones)

	}

	@Test
	def inscribirJugadorYDarDeBajaVerificandoFecha() {

		partido.suscribir(jugador4)
		partido.darDeBaja(jugador4)
		var fechaInfraccion = jugador4.getInfracciones.head.getFecha
		var infraccionMock = new InfraccionBajaSinRemplazo
		infraccionMock.setFecha(01012000)
		Assert.assertEquals(fechaInfraccion,infraccionMock.fecha)

	}
}
