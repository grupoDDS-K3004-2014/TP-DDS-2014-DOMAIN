package domain
interface Observer {

	def void notificarAlta(Participante observable)

	def void notificarBaja()
}
