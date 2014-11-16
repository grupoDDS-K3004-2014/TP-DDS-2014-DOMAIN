package domain.criterios

import domain.jugadores.Participante
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.InheritanceType
import javax.persistence.Inheritance

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
abstract class Criterio {
	@Id
	@GeneratedValue
	@Property long id

	abstract def void actualizarPuntajeCriterio(Participante participante)

}
