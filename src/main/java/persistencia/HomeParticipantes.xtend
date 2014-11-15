package persistencia

import domain.calificaciones.Calificacion
import domain.infracciones.InfraccionMalaConducta
import domain.jugadores.Estandar
import domain.jugadores.Participante
import domain.partido.Partido
import java.util.ArrayList
import java.util.HashSet
import java.util.Set
import org.apache.commons.collections.Closure
import org.hibernate.HibernateException
import org.hibernate.Session

import static persistencia.SessionManager.*

class HomeParticipantes {

	Session sessionDB

	new() {
		init
	}

	def init() {

		startSession

		var erwin = new Estandar => [
			nombre = "Erwin"
			apodo = "Erw"
			fechaNacimiento = "14/02/1993"
			handicap = 5
		]
		var calificacion = Calificacion.nueva(2, "Baboso!", "26/09/2014")
		add(calificacion)

		erwin.calificaciones.add(calificacion)

		calificacion = Calificacion.nueva(5, "Baboso!", "27/09/2014")
		add(calificacion)

		erwin.calificaciones.add(calificacion)
		add(erwin)

		var maggie = new Estandar => [
			nombre = "Maggie"
			apodo = "Purri"
			fechaNacimiento = "28/05/1992"
			handicap = 20
		]
		calificacion = Calificacion.nueva(10, "Trompitástico!", "26/09/2014")
		add(calificacion)

		maggie.calificaciones.add(calificacion)
		add(maggie)

		var mariano = new Estandar => [
			nombre = "Mariano"
			apodo = "das Marian"
			fechaNacimiento = "05/02/1993"
			handicap = 12
		]
		calificacion = Calificacion.nueva(3, "Lagoso", "26/09/2014")
		add(calificacion)

		mariano.calificaciones.add(calificacion)
		add(mariano)

		var roman = new Estandar => [
			nombre = "Roman"
			apodo = "Romi"
			fechaNacimiento = "23/06/1994"
			handicap = 5
		]

		add(roman)

		var pablo = new Estandar => [
			nombre = "Pablo"
			apodo = "Pablito"
			fechaNacimiento = "12/06/1993"
			handicap = 1
		]

		var infraccion = InfraccionMalaConducta.nueva("28/09/2014", "Cagarme con el regalo para Maggie")
		add(infraccion)

		pablo.infracciones.add(infraccion)

		calificacion = Calificacion.nueva(5, "Jugo bien", "26/09/2014")
		add(calificacion)

		pablo.calificaciones.add(calificacion)

		add(pablo)

		var pepeto = new Estandar => [
			nombre = "Pepeto"
			apodo = "el Pepi"
			fechaNacimiento = "12/06/1983"
			handicap = 5
		]
		calificacion = Calificacion.nueva(5, "Meh", "10/10/2010")
		add(calificacion)

		pepeto.calificaciones.add(calificacion)

		calificacion = Calificacion.nueva(3, "Meh", "11/10/2010")
		add(calificacion)

		pepeto.calificaciones.add(calificacion)

		calificacion = Calificacion.nueva(6, "Meh", "12/10/2010")
		add(calificacion)

		pepeto.calificaciones.add(calificacion)
		add(pepeto)

		var rogelio = new Estandar => [
			nombre = "Rogelio"
			apodo = "Rogi"
			fechaNacimiento = "27/04/1990"
			handicap = 5
		]

		calificacion = Calificacion.nueva(5, "Meh", "10/10/2010")
		add(calificacion)

		rogelio.calificaciones.add(calificacion)

		infraccion = InfraccionMalaConducta.nueva("28/09/2014", "Pegarle al referi")
		add(infraccion)

		rogelio.infracciones.add(infraccion)
		add(rogelio)

		var walflavio = new Estandar => [
			nombre = "Walflavio"
			apodo = "Wally"
			fechaNacimiento = "10/02/1980"
			handicap = 5
		]

		add(walflavio)

		var jesus = new Estandar => [
			nombre = "Jesus"
			apodo = "el mesias"
			fechaNacimiento = "00/00/0000"
			handicap = 33
		]

		calificacion = Calificacion.nueva(10, "Resucito el partido", "11/10/2010")
		add(calificacion)

		jesus.calificaciones.add(calificacion)
		add(jesus)

		var sebastian = new Estandar => [
			nombre = "Sebastian"
			apodo = "Sebas"
			fechaNacimiento = "05/02/1990"
			handicap = 8
		]

		calificacion = Calificacion.nueva(5, "Meh", "10/10/2010")
		add(calificacion)

		sebastian.calificaciones.add(calificacion)

		infraccion = InfraccionMalaConducta.nueva("28/09/2014", "Llego muy tarde")
		add(infraccion)

		sebastian.infracciones.add(infraccion)
		add(sebastian)

		var partido1 = new Partido => [
			nombreDelPartido = "El superClasico de Martelli"
			dia = "Sabado"
			horario = 2230
			periodicidad = 2
			fecha = "25/09/2014"
		]
		var partido2 = new Partido => [
			nombreDelPartido = "Los pibes de Accenture"
			dia = "Viernes"
			horario = 1715
			periodicidad = 3
			fecha = "17/09/2014"
		]

		var partido3 = new Partido => [
			nombreDelPartido = "Don Torcuato copa"
			dia = "Lunes"
			horario = 1045
			periodicidad = 1
			fecha = "30/11/2014"
		]

		add(partido1)
		add(partido2)
		add(partido3)

		partido1.suscribir(erwin)
		partido1.suscribir(maggie)
		partido1.suscribir(mariano)
		partido1.suscribir(pablo)
		partido1.suscribir(roman)
		partido1.suscribir(jesus)
		partido1.suscribir(sebastian)
		partido1.suscribir(walflavio)
		partido1.suscribir(pepeto)
		partido1.suscribir(rogelio)

		partido2.suscribir(rogelio)
		partido2.suscribir(pablo)
		partido2.suscribir(walflavio)
		partido2.suscribir(jesus)
		partido2.suscribir(sebastian)
		partido2.suscribir(pepeto)

		partido3.suscribir(erwin)

		merge(partido1)
		merge(partido2)
		merge(partido3)

		erwin.amigos.addAll(new ArrayList<Participante>(#[maggie, mariano, pablo]))
		merge(erwin)
		maggie.amigos.addAll(new ArrayList<Participante>(#[erwin, mariano, roman, pablo]))
		merge(maggie)
		mariano.amigos.addAll(new ArrayList<Participante>(#[erwin, maggie, roman, pablo]))
		merge(mariano)
		pablo.amigos.addAll(new ArrayList<Participante>(#[erwin, maggie, mariano]))
		merge(pablo)
		roman.amigos.addAll(new ArrayList<Participante>(#[erwin, maggie, mariano]))
		merge(roman)
		pepeto.amigos.addAll(new ArrayList<Participante>())
		merge(pepeto)
		rogelio.amigos.addAll(new ArrayList<Participante>(#[jesus, walflavio]))
		merge(rogelio)
		walflavio.amigos.addAll(new ArrayList<Participante>(#[erwin, mariano]))
		merge(walflavio)
		jesus.amigos.addAll(
			new ArrayList<Participante>(#[erwin, maggie, mariano, pablo, roman, pepeto, rogelio, walflavio, sebastian]))
		merge(jesus)
		sebastian.amigos.addAll(new ArrayList<Participante>(#[erwin, maggie]))
		merge(sebastian)

		closeSession

	}

	def merge(Object obj) {
		sessionDB.merge(obj)
	}

	def startSession() {
		sessionDB = sessionFactory.openSession
		sessionDB.beginTransaction

	}

	def closeSession() {
		sessionDB.flush
		sessionDB.transaction.commit
		sessionDB.close
	}

	def void add(Object object) {
		this.executeBatch([session|(session as Session).save(object)])
	}

	def void executeBatch(Closure closure) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			closure.execute(session)
			session.transaction.commit
		} catch (HibernateException e) {
			session.transaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def static Set<Participante> getAll() {
		val session = sessionFactory.openSession
		val query = session.createQuery("from Participante")
		var Set<Participante> hash = new HashSet(query.list())
		session.close
		hash
	}

	def search(String nombre, String fechaNacimiento, int handicapInicial, int handicapFinal, String apodo,
		boolean tieneInfraccion, int promedioDesde, int promedioHasta) {
		new HashSet(
			getAll().filter[jugador|
				this.tieneElNombre(nombre, jugador.nombre) && this.tieneElApodo(apodo, jugador.apodo) &&
					this.cumpleCon(handicapInicial, jugador.handicap) &&
					this.suHandicapEsMenorA(handicapFinal, jugador.handicap) &&
					cumpleInfracciones(tieneInfraccion, jugador) &&
					this.fechaAnteriorA(fechaNacimiento, jugador.fechaNacimiento) &&
					this.tienePromedioMenorA(promedioHasta, jugador.ultimaNota) &&
					this.tienePromedioMayorA(promedioDesde, jugador.ultimaNota)].toList)
	}

	def cumpleCon(int handicapInicial, int handicap) {
		if (handicapInicial == 0) {
			return true
		} else {
			handicap >= handicapInicial
		}
	}

	def tieneElNombre(String string, String nombre) {
		if (string == null) {
			return true
		} else {
			nombre.toString().toLowerCase().contains(string.toString().toLowerCase())
		}
	}

	def tieneElApodo(String apo, String apodo) {
		if (apo == null) {
			return true
		} else {
			apodo.toString().toLowerCase().contains(apo.toString().toLowerCase())
		}
	}

	def fechaAnteriorA(String fechaNacimientoBusqueda, String fechaNacimientoJugador) {
		if (fechaNacimientoBusqueda != "" && fechaNacimientoJugador != null)
			verificarAño(fechaNacimientoBusqueda, fechaNacimientoJugador.substring(6))
		else
			true

	}

	def verificarAño(String fechaBusqueda, String fechaJugador) {
		Integer.parseInt(fechaJugador) < Integer.parseInt(fechaBusqueda)
	}

	def suHandicapEsMenorA(int handicapMayor, int handicap) {
		if (handicapMayor == 0) {
			return true
		} else {
			handicap <= handicapMayor
		}
	}

	def cumpleInfracciones(boolean tieneInfraccion, Participante jugador) {

		if (tieneInfraccion)
			jugador.infracciones.size != 0
		else
			jugador.infracciones.size == 0

	}

	def tienePromedioMenorA(long promedioMayor, long promedio) {
		if (promedioMayor == 0) {
			return true
		} else {
			promedio < promedioMayor
		}
	}

	def tienePromedioMayorA(long promedioMenor, long promedio) {
		if (promedioMenor == 0) {
			return true
		} else {
			promedio > promedioMenor
		}
	}

}
