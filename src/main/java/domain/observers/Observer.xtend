package domain.observers

import domain.jugadores.Participante
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
abstract class Observer {
	
	@Id
	@GeneratedValue
	@Property long id

	abstract def void notificarAlta(Participante observable)

	abstract def void notificarBaja()
}
