package domain

import domain.jugadores.Participante

interface Observer {

	def void notificarAlta(Participante observable)

	def void notificarBaja()
}
