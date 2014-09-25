package domainTests

import java.util.ArrayList
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import domain.jugadores.Participante
import domain.jugadores.Estandar
import domain.partido.Partido
import domain.jugadores.Solidario
import domain.jugadores.Condicional

class EquiposTest {

	Estandar jugador1
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

		arrayPosiciones = new ArrayList(#[1, 3, 5, 7, 9])
		arrayAssert = new ArrayList(#[jugador1, jugador3, jugador5, jugador7, jugador9])

		partido.separarJugadoresOrdenados(arrayPosiciones)
		Assert.assertEquals(arrayAssert, partido.equipoA)
	}

	@Test
	def testGenerarEquiposTentativosAlgoritmoPosiciones() {

		arrayPosiciones = new ArrayList(#[1, 2, 3, 4, 5])
		arrayAssert = new ArrayList(#[jugador1, jugador2, jugador3, jugador4, jugador5])

		partido.separarJugadoresOrdenados(arrayPosiciones)
		Assert.assertEquals(arrayAssert, partido.equipoA)
	}

	@Test
	def testConfirmarEquiposTentativos() {

		arrayPosiciones = new ArrayList(#[1, 3, 5, 7, 9])
		arrayAssert = new ArrayList(#[jugador2, jugador4, jugador6, jugador8, jugador10])

		partido.separarJugadoresOrdenados(arrayPosiciones)
		partido.confirmarDesconfirmarPartido
		Assert.assertEquals(partido.confirmado, "Si")
	}

}
