import java.util.List
import java.util.ArrayList

class DivisionEquipos {
	@Property List<Participante> jugadoresEquipoA = new ArrayList<Participante>
	@Property List<Participante> jugadoresEquipoB = new ArrayList<Participante>

	def distribuirEquipos(List<Participante> jugadoresOrdenados, List<Integer> posicionesDeUnEquipo) {

		jugadoresEquipoA = posicionesDeUnEquipo.map[index|jugadoresOrdenados.get(index - 1)]

		jugadoresEquipoB = jugadoresOrdenados.filter[jugador|!(jugadoresEquipoA.contains(jugador))].toList

	}
}
