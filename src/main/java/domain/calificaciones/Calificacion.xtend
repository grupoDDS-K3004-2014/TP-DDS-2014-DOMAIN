package domain.calificaciones

import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Observable
class Calificacion {

	@Id
	@GeneratedValue
	@Property long id

	@Property int nota
	@Property String descripcion
	@Property String fecha

	def calificacionCorrecta() {
		nota >= 1 && nota <= 10
	}

	def static Calificacion nueva(Integer nota2, String descripcion2, String fecha2) {
		var calificacion = new Calificacion
		calificacion.nota = nota2
		calificacion.descripcion = descripcion2
		calificacion.fecha = fecha2
		calificacion
	}

}
