package domain.notificaciones

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
class Email {
	
	@Id
	@GeneratedValue
	@Property long id
}
