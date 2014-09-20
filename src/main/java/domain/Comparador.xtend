package domain
import java.util.Comparator

class Comparador implements Comparator<Participante> {
	def override int compare(Participante participante1, Participante participante2) {
		val promedio1 = (participante1.puntajesCriterio.fold(0)[total, puntaje|total + puntaje]) /
			participante1.puntajesCriterio.size
		val promedio2 = ( participante2.puntajesCriterio.fold(0)[total, puntaje|total + puntaje]) /
			participante2.puntajesCriterio.size
		return promedio2.compareTo(promedio1)
	}
}
