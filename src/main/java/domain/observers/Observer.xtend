package domain.observers

import domain.jugadores.Participante

interface Observer {

	def void notificarAlta(Participante observable)

	def void notificarBaja()
}
