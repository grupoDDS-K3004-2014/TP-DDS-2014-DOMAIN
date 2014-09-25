package domain.condiciones

import domain.partido.Partido

interface Condicion {

	def boolean verificarCondicion(Partido partido)

}
