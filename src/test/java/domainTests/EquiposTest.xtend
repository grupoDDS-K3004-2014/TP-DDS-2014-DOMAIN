package domainTests

import domain.Condicional
import domain.Estandar
import domain.Participante
import domain.Partido
import domain.Sistema
import domain.Solidario
import java.util.ArrayList
import org.junit.Assert
import org.junit.Before
import org.junit.Test

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
	ArrayList<Participante> arrayAssert

	Partido partido
	Partido partido2

	Sistema datosDelSistema

	@Before
	def void beforeInscripcion() {

		partido = new Partido
		partido2 = new Partido
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
		arrayAssert = new ArrayList<Participante>

		datosDelSistema = new Sistema

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

		arrayAssert.add(jugador2)
		arrayAssert.add(jugador4)
		arrayAssert.add(jugador6)
		arrayAssert.add(jugador8)
		arrayAssert.add(jugador10)

		datosDelSistema.generarEquiposTentativos(partido, arrayPosiciones)
		Assert.assertEquals(arrayAssert, datosDelSistema.equipoA)

		arrayAssert = new ArrayList
		arrayAssert.add(jugador1)
		arrayAssert.add(jugador3)
		arrayAssert.add(jugador5)
		arrayAssert.add(jugador7)
		arrayAssert.add(jugador9)
		Assert.assertEquals(arrayAssert, datosDelSistema.equipoB)

	}

	@Test
	def testGenerarEquiposTentativosAlgoritmoPosiciones() {

		arrayPosiciones.add(1)
		arrayPosiciones.add(4)
		arrayPosiciones.add(5)
		arrayPosiciones.add(8)
		arrayPosiciones.add(9)

		arrayAssert.add(jugador1)
		arrayAssert.add(jugador4)
		arrayAssert.add(jugador5)
		arrayAssert.add(jugador8)
		arrayAssert.add(jugador9)

		datosDelSistema.generarEquiposTentativos(partido, arrayPosiciones)
		Assert.assertEquals(arrayAssert, datosDelSistema.equipoA)

		arrayAssert = new ArrayList
		arrayAssert.add(jugador2)
		arrayAssert.add(jugador3)
		arrayAssert.add(jugador6)
		arrayAssert.add(jugador7)
		arrayAssert.add(jugador10)

		Assert.assertEquals(arrayAssert, datosDelSistema.equipoB)
	}

	@Test
	def testConfirmarEquiposTentativos() {
		arrayPosiciones.add(1)
		arrayPosiciones.add(4)
		arrayPosiciones.add(5)
		arrayPosiciones.add(8)
		arrayPosiciones.add(9)

		arrayAssert.add(jugador1)
		arrayAssert.add(jugador4)
		arrayAssert.add(jugador5)
		arrayAssert.add(jugador8)
		arrayAssert.add(jugador9)

		datosDelSistema.generarEquiposTentativos(partido, arrayPosiciones)
		datosDelSistema.confirmarEquipos(partido)

		Assert.assertEquals(arrayAssert, partido.equipoA)

		arrayAssert = new ArrayList
		arrayAssert.add(jugador2)
		arrayAssert.add(jugador3)
		arrayAssert.add(jugador6)
		arrayAssert.add(jugador7)
		arrayAssert.add(jugador10)
		Assert.assertEquals(arrayAssert, partido.equipoB)
	}

	@Test
	def testArrays() {

		partido2.jugadoresOrdenados.add(jugador1)
		partido2.jugadoresOrdenados.add(jugador2)
		partido2.jugadoresOrdenados.add(jugador3)
		partido2.jugadoresOrdenados.add(jugador4)

		arrayPosiciones.add(1)
		arrayPosiciones.add(3)

		arrayAssert.add(jugador1)
		arrayAssert.add(jugador3)

		datosDelSistema.generarEquiposTentativos(partido2, arrayPosiciones)
		Assert.assertEquals(arrayAssert, datosDelSistema.equipoA)

	}
}
