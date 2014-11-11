package domain.condiciones

import domain.partido.Partido
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity
import javax.persistence.InheritanceType
import javax.persistence.Inheritance

@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
abstract class Condicion {

 	@Id
 	@GeneratedValue
	@Property long id
	abstract def boolean verificarCondicion(Partido partido)

}
