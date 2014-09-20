import org.junit.Assert
import org.junit.Before
import org.junit.Test

class CalificacionesTests {

	Calificacion calificacion = new Calificacion
	Partido partido = new Partido
	Participante jugador1 = new Estandar
	Participante jugador2 = new Estandar
	NotificarConfirmacionAAmigosObserver observerNotificarAmigos = new NotificarConfirmacionAAmigosObserver
	NotificarEquipoCompletoConseguidoOPerdidoObserver observerNotificarAdministrador = new NotificarEquipoCompletoConseguidoOPerdidoObserver
	ServidorDeEmails gmail = new ServidorDeEmails

	@Before
	def void beforeInscripcion() {

		partido.setDia(Dia.Lunes)
		partido.setHorario(18)
		partido.setPeriodicidad(1)
		partido.setFecha(01012000)

		observerNotificarAmigos.setServidorEmails(gmail)
		observerNotificarAdministrador.setServidorEmails(gmail)

		partido.observerAdd(observerNotificarAmigos)
		partido.observerAdd(observerNotificarAdministrador)

	}

	@Test
	def calificarJugadorTest() {
		partido.suscribir(jugador1)
		partido.suscribir(jugador2)
		calificacion.nota = 10
		calificacion.descripcion = "master"
		jugador1.calificarJugador(partido, jugador2, calificacion)
		val cantidadCalificaciones = jugador2.getCalificaciones.size()
		Assert.assertEquals(1, cantidadCalificaciones)
	}

	@Test
	def calificacionNoApareceEnListaTest() {
		partido.suscribir(jugador1)
		calificacion.nota = 7
		calificacion.descripcion = "aprueba por promocion"
		jugador1.calificarJugador(partido, jugador2, calificacion)
		val cantidadCalificaciones = jugador2.getCalificaciones.size()
		Assert.assertEquals(0, cantidadCalificaciones)
	}
}
