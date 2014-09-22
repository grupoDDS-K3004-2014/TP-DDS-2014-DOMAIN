package domainTests

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import domain.Participante
import domain.Partido
import domain.Sistema
import domain.Estandar
import domain.Solidario
import domain.Condicional
import java.util.ArrayList
import java.util.Arrays

class EquiposTest {

	Participante jugador1
	Participante jugador2
	Participante jugador3
	Participante jugador4
	Participante jugador5
	Participante jugador6
	Participante jugador7
	Participante jugador8
	Participante jugador9
	Participante jugador10
	ArrayList<Integer> arrayPosiciones

	Partido partido

	Sistema datosDelSistema

	@Before
	def void beforeInscripcion() {

		partido = new Partido
		jugador1 = new Estandar
		jugador2 = new Solidario
		jugador3 = new Estandar
		jugador4 = new Condicional
		jugador5 = new Condicional
		jugador6 = new Estandar
		jugador7 = new Estandar
		jugador8 = new Estandar
		jugador9 = new Estandar
		jugador10 = new Estandar
		arrayPosiciones = new ArrayList<Integer>

		datosDelSistema = new Sistema
		datosDelSistema.fechaDelDia = 17062014

		////esto es realidad es el output de sistema.oganizarJugadoresPorCriterio()
		partido.jugadoresOrdenados.add(jugador1)
		partido.jugadoresOrdenados.add(jugador2)
		partido.jugadoresOrdenados.add(jugador3)
		partido.jugadoresOrdenados.add(jugador4)
		partido.jugadoresOrdenados.add(jugador5)
		partido.jugadoresOrdenados.add(jugador6)
		partido.jugadoresOrdenados.add(jugador7)
		partido.jugadoresOrdenados.add(jugador8)
		partido.jugadoresOrdenados.add(jugador9)
		partido.jugadoresOrdenados.add(jugador10)
	}

	@Test
	def testGenerarEquiposTentativosAlgoritmoParesImpares() {
		arrayPosiciones.add(2)
		arrayPosiciones.add(4)
		arrayPosiciones.add(6)
		arrayPosiciones.add(8)
		arrayPosiciones.add(10)
		datosDelSistema.generarEquiposTentativos(partido, arrayPosiciones)
		Assert.assertEquals(new ArrayList<Participante>(Arrays.asList(jugador2, jugador4, jugador6, jugador8, jugador10)), datosDelSistema.equipoA)
		Assert.assertEquals(new ArrayList<Participante>(Arrays.asList(jugador1, jugador3, jugador5, jugador7, jugador9)), datosDelSistema.equipoB)

	}

	@Test
	def testGenerarEquiposTentativosAlgoritmoPosiciones() {
		arrayPosiciones.add(1)
		arrayPosiciones.add(4)
		arrayPosiciones.add(5)
		arrayPosiciones.add(8)
		arrayPosiciones.add(9)
		datosDelSistema.generarEquiposTentativos(partido, arrayPosiciones)
		Assert.assertEquals(new ArrayList<Participante>(Arrays.asList(jugador1, jugador4, jugador5, jugador8, jugador9)), datosDelSistema.equipoA)
		Assert.assertEquals(new ArrayList<Participante>(Arrays.asList(jugador2, jugador3, jugador6, jugador7, jugador10)), datosDelSistema.equipoB)
	}

	@Test
	def testConfirmarEquiposTentativos() {
		arrayPosiciones.add(1)
		arrayPosiciones.add(4)
		arrayPosiciones.add(5)
		arrayPosiciones.add(8)
		arrayPosiciones.add(9)
		datosDelSistema.generarEquiposTentativos(partido, arrayPosiciones)
		datosDelSistema.confirmarEquipos(partido)
		Assert.assertEquals(new ArrayList<Participante>(Arrays.asList(jugador1, jugador4, jugador5, jugador8, jugador9)), partido.equipoA)
		Assert.assertEquals(new ArrayList<Participante>(Arrays.asList(jugador2, jugador3, jugador6, jugador7, jugador10)), partido.equipoB)
	}

}
