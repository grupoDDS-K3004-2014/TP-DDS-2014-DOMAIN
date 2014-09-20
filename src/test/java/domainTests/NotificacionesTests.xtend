package domainTests

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import domain.Estandar
import domain.Partido
import domain.Participante
import domain.NotificarConfirmacionAAmigosObserver
import domain.Solidario
import domain.Condicional
import domain.NotificarEquipoCompletoConseguidoOPerdidoObserver
import domain.ServidorDeEmails
import domain.Dia
import domain.InfraccionBajaSinRemplazo

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

		partido.setDia(Dia.Lunes)
		partido.setFecha(01012000)

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
		var fechaInfraccion = jugador4.getInfracciones.head.getFecha
		var infraccionMock = new InfraccionBajaSinRemplazo
		infraccionMock.setFecha(01012000)
		Assert.assertEquals(fechaInfraccion, infraccionMock.fecha)

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
