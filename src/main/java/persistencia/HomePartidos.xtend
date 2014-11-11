package persistencia

import domain.partido.Partido
import java.util.HashSet
import java.util.Set

import static persistencia.SessionManager.*
import org.apache.commons.collections.Closure
import org.hibernate.HibernateException
import org.hibernate.Session

class HomePartidos {

	new() {
		init
	}

	def Set<Partido> getAll() {
		val session = sessionFactory.openSession
		val query = session.createQuery("from Partido")
		new HashSet(query.list())
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

	def void init() {

		if (getAll().empty) {
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

		}

	}

}
