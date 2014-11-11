package domainTests


import domain.jugadores.Condicional
import domain.jugadores.Estandar
import domain.jugadores.Participante
import domain.jugadores.Solidario
import domain.notificaciones.ServidorDeEmails
import domain.observers.NotificarConfirmacionAAmigosObserver
import domain.observers.NotificarEquipoCompletoConseguidoOPerdidoObserver
import domain.partido.Partido
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import domain.infracciones.InfraccionBajaSinRemplazo

class NotificacionesTests {

	Partido partido = new Partido
	Participante jugador1 = new Estandar
	Participante jugador2 = new Solidario
	Participante jugador3 = new Estandar
	Participante jugador4 = new Condicional
	NotificarConfirmacionAAmigosObserver observerNotificarAmigos = new NotificarConfirmacionAAmigosObserver
	NotificarEquipoCompletoConseguidoOPerdidoObserver observerNotificarAdministrador = new NotificarEquipoCompletoConseguidoOPerdidoObserver
	ServidorDeEmails gmail = new ServidorDeEmails

	@Before
	def void beforeInscripcion() {

		partido.setDia("Lunes")
		partido.setFecha("01/01/2000")

		observerNotificarAmigos.setServidorEmails(gmail)
		observerNotificarAdministrador.setServidorEmails(gmail)

		partido.observerAdd(observerNotificarAmigos)
		partido.observerAdd(observerNotificarAdministrador)

	}

	@Test
	def notificarPartidoAlAdministrador() {

		partido.suscribir(jugador1)
		partido.suscribir(jugador3)
		val notificaciones = gmail.cantidadNotificaciones
		Assert.assertEquals(1, notificaciones)

	}

	@Test
	def completarEquipoCambiarJugadorDarDeBajaSinRemplazo() {

		partido.suscribir(jugador1)
		partido.suscribir(jugador3)
		partido.darDeBaja(jugador1, jugador4)
		partido.darDeBaja(jugador4)
		val notificaciones = gmail.cantidadNotificaciones
		Assert.assertEquals(3, notificaciones)

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
		Assert.assertTrue(InfraccionBajaSinRemplazo.nueva(partido.fecha, "").igual(jugador4.infracciones.head))

	}

	@Test
	def inscribirJugadorYNotificarAmigo() {

		jugador4.agregarAmigo(jugador3)
		partido.suscribir(jugador4)
		val notificaciones = gmail.cantidadNotificaciones
		Assert.assertEquals(1, notificaciones)

	}

	@Test
	def inscribirJugadorYNotificar2Amigos() {

		jugador4.agregarAmigo(jugador1)
		jugador4.agregarAmigo(jugador2)
		partido.suscribir(jugador4)
		val notificaciones = gmail.cantidadNotificaciones
		Assert.assertEquals(2, notificaciones)

	}

	@Test
	def inscribirJugadorSinAmigos() {

		partido.suscribir(jugador4)
		val notificaciones = gmail.cantidadNotificaciones
		Assert.assertEquals(0, notificaciones)
	}

}
