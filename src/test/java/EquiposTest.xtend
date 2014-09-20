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

	Partido partido
	DivisionEquipos algoritmoDivision
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

		datosDelSistema = new Sistema
		datosDelSistema.fechaDelDia = 17062014
		algoritmoDivision = new DivisionEquipos

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
		datosDelSistema.generarEquiposTentativos(algoritmoDivision,partido, #[2, 4, 6, 8, 10])
		Assert.assertEquals(#[jugador2, jugador4, jugador6, jugador8, jugador10], algoritmoDivision.jugadoresEquipoA)
		Assert.assertEquals(#[jugador1, jugador3, jugador5, jugador7, jugador9], algoritmoDivision.jugadoresEquipoB)

	}

	@Test
	def testGenerarEquiposTentativosAlgoritmoPosiciones() {
		datosDelSistema.generarEquiposTentativos(algoritmoDivision,partido, #[1, 4, 5, 8, 9])
		Assert.assertEquals(#[jugador1, jugador4, jugador5, jugador8, jugador9], algoritmoDivision.jugadoresEquipoA)
		Assert.assertEquals(#[jugador2, jugador3, jugador6, jugador7, jugador10], algoritmoDivision.jugadoresEquipoB)
	}

	@Test
	def testConfirmarEquiposTentativos() {
		datosDelSistema.generarEquiposTentativos(algoritmoDivision,partido, #[1, 4, 5, 8, 9])
		datosDelSistema.confirmarEquipos(algoritmoDivision, partido)
		Assert.assertEquals(#[jugador1, jugador4, jugador5, jugador8, jugador9], partido.equipoA)
		Assert.assertEquals(#[jugador2, jugador3, jugador6, jugador7, jugador10], partido.equipoB)
	}

}
