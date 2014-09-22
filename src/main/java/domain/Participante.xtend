package domain
import java.util.ArrayList
import java.util.List
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.Entity
import java.util.Date
//import org.uqbar.commons.model.UserException
//PROBLEMAS EN LA FECHA

@Observable
class Participante extends Entity{

	@Property List<Calificacion> calificaciones = new ArrayList<Calificacion>
	@Property ArrayList<Participante> amigos = new ArrayList<Participante>
	@Property ArrayList<Infraccion> infracciones = new ArrayList<Infraccion>
	@Property String nombre
	@Property Date fechaNacimiento
	@Property Sistema datosDelOrganizadorDePartidos
	@Property ArrayList<Integer> puntajesCriterio = new ArrayList
	@Property int handicap
	@Property String apodo
    @Property long promedio

	def serDezplazadoSolidario(Partido partido) {
	}

	def serDezplazadoCondicional(Partido partido) {
	}

	def reemplazarSegunPrioridad(Partido partido, Participante jugador) {
	}

	def void inscripcion(Partido partido) {		
	}

	def agregarCondicion(Condicion condicion) {
	}

	def agregarInfraccion(Infraccion infraccion) {
		infracciones.add(infraccion)
	}

	def agregarAmigo(Participante amigo) {
		amigos.add(amigo)
	}

	def calificarJugador(Partido partido, Participante jugador, Calificacion calificacion) {
		if (partido.participantes.contains(this) && partido.participantes.contains(jugador) && calificacion.nota >= 1 &&
			calificacion.nota <= 10) {
			jugador.calificaciones.add(calificacion)
		}
	}

	def proponer(Propuesta propuesta) {
		datosDelOrganizadorDePartidos.propuestas.add(propuesta)
	}
	
	def cumpleCon(int handicapInicial) {
		if(handicapInicial==0){return true}
		else{handicap>=handicapInicial}
	}
	
	
	def tieneElNombre(String string) {
		if(string==null){return true}
		else{nombre==string}
		nombre.toString().toLowerCase().contains(string.toString().toLowerCase())
	}
	
	def tieneElApodo(String apo) {
		if(apo==null){return true}
		else{apodo==apodo}
		apo.toString().toLowerCase().contains(apodo.toString().toLowerCase())
	}
	
	def fechaAnteriorA(Date date) {
		//if(fechaNacimiento!=null&&date!=null){fechaNacimiento.before(date)}
		//else{throw new UserException("Debe Ingresar fecha")}
		//PROBLEMAS ACA
		true
	}
	
	def suHandicapEsMenorA(int handicapMayor) {
		if (handicapMayor==0){return true}
		else{handicap<=handicapMayor}
	}
	
	def cantidadInfracciones(){
		infracciones.size
	}
	
	def cumpleInfracciones(boolean tieneInfraccion,boolean noTieneInfraccion){
		if (tieneInfraccion && noTieneInfraccion==false){cantidadInfracciones!=0}
		else{if (tieneInfraccion==false && noTieneInfraccion){cantidadInfracciones==0}
			else{true}
			}
			
			}
			
		def tienePromedioMenorA(long promedioMayor){
			if(promedioMayor==0){return true}
			else
			{promedio<promedioMayor}
	}
	
	def tienePromedioMayorA(long promedioMenor){
		if(promedioMenor==0){return true}
			else{promedio>promedioMenor}
	}
	
	def setPromedio(long promedio){
		this.puntajesCriterio.fold(0)[total, puntaje|total + puntaje] /this.puntajesCriterio.size
	}
	
	
}


