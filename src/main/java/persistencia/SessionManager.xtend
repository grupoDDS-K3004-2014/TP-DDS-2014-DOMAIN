package persistencia

import domain.calificaciones.Calificacion
import domain.condiciones.Condicion
import domain.condiciones.CondicionDia
import domain.condiciones.CondicionHora
import domain.condiciones.CondicionPeriodicidad
import domain.criterios.Criterio
import domain.criterios.CriterioCompuesto
import domain.criterios.CriterioHandicap
import domain.criterios.CriterioNCalificaciones
import domain.criterios.CriterioUltimoPartido
import domain.infracciones.Infraccion
import domain.infracciones.InfraccionBajaSinRemplazo
import domain.infracciones.InfraccionMalaConducta
import domain.jugadores.Condicional
import domain.jugadores.Estandar
import domain.jugadores.Participante
import domain.jugadores.Solidario
import domain.notificaciones.Email
import domain.notificaciones.ServidorDeEmails
import domain.observers.NotificarConfirmacionAAmigosObserver
import domain.observers.NotificarEquipoCompletoConseguidoOPerdidoObserver
import domain.observers.Observer
import domain.partido.Partido
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration

class SessionManager {
	static ThreadLocal<Session> tlSession = new ThreadLocal
	static SessionFactory sessionFactory;

	def static getSession(){
		tlSession.get
	}
	
	def static setSession(Session session){
		tlSession.set(session)
	}
	
	def synchronized static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			val cfg = new Configuration();
			cfg.configure();
			
			addClasses(cfg)
			
			sessionFactory = cfg.buildSessionFactory();
		}

		return sessionFactory;
	}
	
	def static addClasses(Configuration cfg) {
		
	cfg.addAnnotatedClass(Calificacion)
	cfg.addAnnotatedClass(Criterio)
	cfg.addAnnotatedClass(CriterioCompuesto)
	cfg.addAnnotatedClass(CriterioHandicap)
	cfg.addAnnotatedClass(CriterioNCalificaciones)
	cfg.addAnnotatedClass(CriterioUltimoPartido)
	cfg.addAnnotatedClass(Infraccion)
	cfg.addAnnotatedClass(InfraccionBajaSinRemplazo)
	cfg.addAnnotatedClass(InfraccionMalaConducta)
	cfg.addAnnotatedClass(Participante)
	cfg.addAnnotatedClass(Solidario)
	cfg.addAnnotatedClass(Estandar)
	cfg.addAnnotatedClass(Condicional)
	cfg.addAnnotatedClass(Partido)
	cfg.addAnnotatedClass(Condicion)
	cfg.addAnnotatedClass(CondicionDia)
	cfg.addAnnotatedClass(CondicionHora)
	cfg.addAnnotatedClass(CondicionPeriodicidad)
	cfg.addAnnotatedClass(Observer)
	cfg.addAnnotatedClass(NotificarConfirmacionAAmigosObserver)
	cfg.addAnnotatedClass(NotificarEquipoCompletoConseguidoOPerdidoObserver)
	cfg.addAnnotatedClass(ServidorDeEmails)
	cfg.addAnnotatedClass(Email)
		
	
	}
	
	def static startApplication(){
		getSessionFactory
	}
	
	def static closeApplication(){
		if(sessionFactory != null)
			sessionFactory.close	
	}
	
	def static openSession(){
		var Session session = getSession;
		if(session == null){
			session = getSessionFactory().openSession();
			session.beginTransaction();
			tlSession.set(session)
		}
	}
	
	def static commit(){
		if(session != null){
			println("Commit de la transaccion")
			session.flush
			session.transaction.commit
		}				
	}
		

	def static closeSession(){
		var Session session = getSession;
		if(session != null){
			println("Cierro la transaccion")
			if(session.transaction.active)
				session.transaction.rollback
			session.close
			tlSession.set(null)
		}		
	}	
	
}