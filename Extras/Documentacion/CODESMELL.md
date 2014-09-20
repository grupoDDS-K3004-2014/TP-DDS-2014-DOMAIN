Clase Partido, modificaciones:

•	new() {
		inscriptos = new ArrayList<Jugador>
		estado = "A"
		distribucionEquipos = 5 // par/impar
		criterioOrdenamiento = new CriterioOrdenamiento
	}

Inicializa las instancias cuando se crean, pero también están definidos los @Property(es decir se definen los get y set):

	@Property List<Jugador> inscriptos
	@Property Equipo equipo1
	@Property Equipo equipo2
	//String estado
	@Property CriterioOrdenamiento criterioOrdenamiento
	//@Property int distribucionEquipos // 5 es par/impar, 16 = 1,4,5,8,9 vs. 2,3,6,7,10
	@Property DistribucionDeEquipos distribucionDeEquipos

Hay repetición de lógica, porque con el set se  puede inicializar cada objeto, entonces se elimina el new() y quedan los @Property.


Modificación clase Partido:

•	Se cambia  este código:

         def void inscribir(Jugador jugador) {
		if (inscriptos.size < 10) {
			this.inscriptos.add(jugador)
		} else {
			if (this.hayAlgunJugadorQueCedaLugar()) {
				this.inscriptos.remove(this.jugadorQueCedeLugar())
				this.inscriptos.add(jugador)
			} else {
				throw new BusinessException("No hay más lugar")
			}
		}
Por:

def void inscribir(Jugador jugador) {

		if (inscriptos.size < 10) {
			this.inscriptos.add(jugador)
			jugador.reemplazable()
		} else {
			this.eliminarReemplazable()
			this.inscriptos.add(jugador)
		}
	}

	}

Se agrega el método jugador.reemplazable() para agregar en una lista los jugadores que tienen una inscripción del tipo Solidario.
eliminarReemplazable() elimina el primer jugador de inscripción solidaria que haya en la lista de inscriptos.



•	String estado : se elimina, ya que el partido se cierra con el armado de equipos.Por lo tanto se eliminan:  método  cerrar() y los estados en el método validarInscripcion() , de manera que queda:
def validarInscripcion() {
		if (inscriptos.size < 10) {
			return -1
		}
	
	return 0
	}
•	@Property int distribucionEquipos // 5 es par/impar, 16 = 1,4,5,8,9 vs. 2,3,6,7,10 se debe cambiar .Hay un code smell:  primitive Obsession, porque  para armar los equipos se utiliza un int y no objeto con compartimiento. 
Si los criterios fueran objetos, en ellos podría delegarse el método distribuirEquipo() y validarIncripcion().De esta manera se aprovecharía  el polimorfismo entre las distribuciones, aumentaría la cohesión y se reduciría el acoplamiento debido que la clase partido ya no se encargaría del armado de equipos, sino que cada criterio tendría de esa tarea. Además, el diseño se volvería flexible debido a que se podría agregar otras distribuciones a futuro fácilmente, porque se agregaría una clase (y no habría que modificar la clase Partido).


Entonces queda:

@Property DistribucionDeEquipos distribucionDeEquipos

Y por lo tanto cambia el método generar equipos:

def generarEquipos() {
		
	distribucionDeEquipos.distribuirEquipos(this.ordenarEquipos())
}

Se crea una clase abstracta llamada DistribucionDeEquipos, en donde se define el método distribuirEquipos():


    abstract class DistribucionDeEquipos {

	
	def void distribuirEquipos(List<Jugador> inscriptos){
		validarInscripcion(inscriptos)
		this.distribuir(inscriptos)
	}
	
	def void distribuir(List<Jugador> inscriptos)
	
	def void validarInscripcion(List<Jugador> inscriptos){
		if (inscriptos.size<10)
		throw new BusinessException("Hay menos de 10 jugadores inscriptos y no alcanzan para armar equipos")
	}
	
}

Antes de armar los equipos se realiza la validación de los inscriptos.Y se lanza un mesnaje de error más expresivo(diferente al anteror que era: “hubo un error”).

Se crean dos subclases de DistribucionDeEqupos(por ahora hay solamente dos distribuciones):


class DistribucionPar extends DistribucionDeEquipos {
	
	List<Jugador> equipoA
	List<Jugador> equipoB
	
	override distribuir(List<Jugador> inscriptos){
		equipoA = newArrayList(inscriptos.get(0), inscriptos.get(2), inscriptos.get(4), inscriptos.get(6),inscriptos.get(8))
		equipoB=newArrayList(inscriptos.get(1), inscriptos.get(3), inscriptos.get(5), inscriptos.get(7),inscriptos.get(9))
}

}

class DistribucionAleatoria extends DistribucionDeEquipos{
	
	List<Jugador> equipoA
	List<Jugador> equipoB
	
	override distribuir(List<Jugador> inscriptos){
		equipoA = newArrayList(inscriptos.get(0), inscriptos.get(3), inscriptos.get(4), inscriptos.get(7),inscriptos.get(8))
		equipoB=newArrayList(inscriptos.get(1), inscriptos.get(2), inscriptos.get(5), inscriptos.get(6),inscriptos.get(9))
}


En la clase  DistribucionPar hay repetición de código(duplicated code en la formación de equipos), se cambia por:
	
	override distribuir(List<Jugador> inscriptos){
		for (Jugador jugador:inscriptos)
		if(inscriptos.indexOf(jugador)%2==0){equipoA.add(jugador)}
		 else{equipoB.add(jugador)}
		 }
		


•	Se cambia el nombre del método ordenarEquipos() (porque ordena la lista de inscriptos no la de los equipos) y recibe como parámetro la lista de inscriptos (que es lo único que necesita de partido: presenta el code smell message chains). 
Entonces:
def List<Jugador> ordenarEquipos(){
		criterioOrdenamiento.ordenar(inscriptos)
	}

Queda: 
def List<Jugador> ordenarInscriptos (){
		criterioOrdenamiento.ordenar(inscriptos)
	}

Y también cambia:

class OrdenamientoPorHandicap implements CriterioOrdenamiento
	
	def override ordenar(Partido partido) {
		partido.getInscriptos.sortBy(calcularValor()).clone.reverse
	}

class OrdenamientoMix implements CriterioOrdenamiento 

def override ordenar(Partido partido) {
		partido.getInscriptos.sortBy(calcularValor()).clone.reverse
	}
class OrdenamientoCalificacionUltimos2Partidos implements CriterioOrdenamiento
def override ordenar(Partido partido) {
		partido.getInscriptos.sortBy (calcularValor()).clone.reverse
	}

Por:
class OrdenamientoPorHandicap implements CriterioOrdenamiento

def override ordenar(List<Jugador> inscriptos) {
		inscriptos.sortBy(calcularValor()).clone.reverse
	}




class OrdenamientoMix implements CriterioOrdenamiento {

	List<CriterioOrdenamiento> criterios 

	new() {
		criterios = new ArrayList<CriterioOrdenamiento>
	}

	def override ordenar(List<Jugador> inscriptos) {
		inscriptos.sortBy(calcularValor()).clone.reverse
	}


class OrdenamientoCalificacionUltimos2Partidos implements CriterioOrdenamiento 
def override ordenar(List<Jugador> inscriptos) {
		inscriptos.sortBy (calcularValor()).clone.reverse
	}
	
Además, no es necesario el mensaje clone:


def override ordenar(List<Jugador> inscriptos) {
		inscriptos.sortBy(calcularValor()).reverse
	}
class OrdenamientoMix implements CriterioOrdenamiento {

	List<CriterioOrdenamiento> criterios 

	new() {
		criterios = new ArrayList<CriterioOrdenamiento>
	}

	def override ordenar(List<Jugador> inscriptos) {
		inscriptos.sortBy(calcularValor()).reverse
	}


class OrdenamientoCalificacionUltimos2Partidos implements CriterioOrdenamiento 
def override ordenar(List<Jugador> inscriptos) {
		inscriptos.sortBy (calcularValor()).reverse
	}

•	Cambio interfaz CriterioOrdenamiento: en todas las clases debería implementarse el método ordenar(List<Jugador> inscriptos), que es el mismo en todas, se repite código (code smell: duplicated code). Entonces la interfaz pasa a clase abstracta y se define en la clase padre el métdo ordenar( List<Jugador> inscriptos) y se lo elimina de sus subclases:
abstract class CriterioOrdenamiento {

	def List<Jugador> ordenar(List<Jugador> inscriptos){
		inscriptos.sortBy(calcularValor()).reverse
	}

	def (Jugador) => Double calcularValor(){}
	
	}

•	Eliminación de la clase Equipo, es un Data Class debido a que solo tiene get y set de equipo. 
La clase no es necesaria, porque no tiene comportamiento, un equipo se arma cuando se distribuyen los equipos y es una lista de inscriptos (jugadores).También se eliminan por esta decisión @Property Equipo equipo1 y @Property Equipo equipo2 de la clase Partido.

Modificación Test:

No es necesario tener definidos partido1 y partidoOk. Se repite código, por lo tanto se deja un solo partido(partidoOk) y se modifica en los test correspondiente partiodo1 por partidoOk

             inscribir(partidoOk, sytek)
		inscribir(partidoOk, chicho)
		inscribir(partidoOk, pato)
		inscribir(partidoOk, lechu)
		inscribir(partidoOk, rodri)
		inscribir(partidoOk, mike)
		inscribir(partidoOk, dodi)
		inscribir(partidoOk, eric)
		inscribir(partidoOk, leo)
	inscribir(partidoOk, ferme)


•	Este test esta demás porque el partido se considera cerrado una vez que se crearon los equipos según la distribución:

@Test(expected=typeof(BusinessException))
	def void partidoSinIniciarNoPuedeGenerarEquipos() {
		(1 .. 4).forEach[inscribir(partidoPocosJugadores, new Jugador)]
		partidoPocosJugadores.generarEquipos
	}


•	Los nombres de los test no son apropiados: generarEquiposPorHandicap(),generarEquiposPorCalificacionUltimos2Partidos(),generarEquiposPorMixDeCriterios()
No se generan equipos, sino que se ordenan a los inscriptos (jugadores)por algún criterio.

Se cambia prefijo “generarEquipos” por “OrdenarJugadores”.


		
Borrado del tests:
/** *************************************************************************
	 * METODOS AUXILIARES DE LOS TESTS
	 ****************************************************************************/
	def void inscribir(Partido partido, Jugador jugador) {
		partido.inscribir(jugador)
	}

}

                  inscribir(partidoOk, sytek)
		inscribir(partidoOk, chicho)
		inscribir(partidoOk, pato)
		inscribir(partidoOk, lechu)
		inscribir(partidoOk, rodri)
		inscribir(partidoOk, mike)
		inscribir(partidoOk, dodi)
		inscribir(partidoOk, eric)
		inscribir(partidoOk, leo)
		inscribir(partidoOk, ferme)
		inscribir(partido1, sytek)
		inscribir(partido1, chicho)
		inscribir(partido1, pato)
		inscribir(partido1, lechu)
		inscribir(partido1, rodri)
		inscribir(partido1, mike)
		inscribir(partido1, dodi)
		inscribir(partido1, roly)
		inscribir(partido1, eric)
		inscribir(partido1, leo)
		inscribir(partido1, ferme)

(1 .. 7).forEach[inscribir(partidoPocosJugadores, new Jugador)]
Estaba demás, se repite código, porque en la clase partido ya existe el método: 
def void inscribir(Jugador jugador).

•	Faltaban test de  distribución:

@Test
	def void distribuirEquiposParEImparListaPar() {
	partidoOk.criterioOrdenamiento= new OrdenamientoPorHandicap
	partidoOk.distribucionDeEquipos= new DistribucionPar
	 partidoOk.generarEquipos()
	Assert.assertArrayEquals(#[ferme, dodi, chicho, rodri, leo],partidoOk.distribucionDeEquipos.equipoA)
	
	}
	
	@Test
	def void distribuirEquiposParEImparListaImpar() {
	partidoOk.criterioOrdenamiento= new OrdenamientoPorHandicap
	partidoOk.distribucionDeEquipos= new DistribucionPar
	 partidoOk.generarEquipos()
	Assert.assertArrayEquals(#[pato, lechu,eric, sytek, mike],partidoOk.distribucionDeEquipos.equipoB)
	}

 	  @Test
	def void distribuirEquiposAlternandoPosicion14589() {
		partidoOk.criterioOrdenamiento= new OrdenamientoPorHandicap
	partidoOk.distribucionDeEquipos= new DistribucionAleatoria
		partidoOk.generarEquipos
		
Assert.assertArrayEquals(#[ferme, lechu,  chicho, sytek, leo],partidoOk.distribucionDeEquipos.equipoA)
		
	}
	
	@Test
	def void distribuirEquiposAlternandoPosicion02367() {
		partidoOk.criterioOrdenamiento= new OrdenamientoPorHandicap
	partidoOk.distribucionDeEquipos= new DistribucionAleatoria
		partidoOk.generarEquipos
		
Assert.assertArrayEquals(#[pato,  dodi, eric, rodri, mike],partidoOk.distribucionDeEquipos.equipoB)
		
	}
	

Modificaciones en clase Jugador:
•	Se repite código, hay tres formas de inicializar:
1.	new() {
		this.puntajes = new ArrayList<Double>
		this.calificacion = null
             this.criterioInscripcion = new ModoEstandar
		this.nombre = ""
	}

2.	new(String nombre, double calificacion, List<Double> puntajes) {
		this.calificacion = calificacion
		this.puntajes = puntajes	
              this.criterioInscripcion = new ModoEstandar
		this.nombre = nombre
3.	@Property String nombre	
	@Property Double calificacion
	@Property List<Double> puntajes
	@Property CriterioInscripcion criterioInscripcion

Se deja la última opción, para poder  inicializar en el test y no en la implementación. Es un error de diseño tener todos los jugadores con un modoEstandar y tener un método  que modifique el modo:

def modoSolidario() {
		criterioInscripcion = new ModoSolidario
	}

Por eso, éste se elimina, y directamente se inicializa en el test el criterio de inscripción como solidario o como estándar.

•	Quedan los métodos:
def boolean dejaLugar() {
		criterioInscripcion.dejaLugar(this)
	}

	def reemplazable() {
		criterioInscripcion.agregaReemplazable(this)
	}
Se delega a cada criterio de inscripción (ya que es conocido por el jugador), el método dejaLugar() y agregarReemplazable(), ya que depende de su modo de inscripción la posibilidad de ser reemplazado.

