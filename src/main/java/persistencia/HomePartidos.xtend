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
		
	}

	def static Set<Partido> getAll() {
		val session = sessionFactory.openSession
		session.beginTransaction
		
		val query = session.createQuery("from Partido")
		var Set<Partido> hash = new HashSet(query.list())
	
		session.transaction.commit	
		session.close
		hash
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

	def search(String nombre) {
		val resultados = getAll()
		resultados.filter[partido|partido.nombreDelPartido == nombre]
	}

}
