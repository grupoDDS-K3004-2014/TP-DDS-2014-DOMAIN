Tp-DDS-Grupo2-2014
==================

Tp de Diseño de Sistemas


Changelog:

15/5 : Refactor de formato y nombres de métodos. Cambio de nombre al proyecto. Incorporado las condiciones (solamente 3 por el momento: Dia, Hora y Periodicidad). Algunos tests agregados. Cambio de nombre a los paquetes. Agregado otra rama de trabajo


ToDo: Agregar más tests y RuntimeExceptions


--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


<h2>Entrega 2:</h2>

•	Cómo se incorpora cada funcionalidad pedida a lo desarrollado anteriormente

La solución con decorator solo agrega una superclase llamada Partido. La clase que anteriormente conocíamos como Partido tuvo que refactorearse a PartidoPosta. Esta, junto con PartidoDecorator,  se extiende de la superclase, la cual agrega las funcionalidades necesarias. La lógica de PartidoPosta no es alterada.
Por su parte, el observer implicó agregar la interfaz Observer, la cual es conocida por diferentes clases “observadoras” correspondientes a las diferentes funcionalidades (notificar a la lista de amigos y notificar al administrador por temas relacionados con los equipos completos). Partido es quien tiene una colección de observers, por lo tanto sus métodos fueron modificados para agregar estas llamadas a la nueva interfaz.

•	Qué consecuencias trae en cada solución el manejo de la identidad de los objetos existentes  

En la solución con observer no es necesario pensar en manejo de identidad ya que el comportamiento va a estar dado por la clase en sí (Partido) y además no hay objetos compartidos (solo el mock servidorDeEmails). Por otro lado, en la solución con decorator, si bien el patrón utilizado se presta para hablar de identidad ya que vas referenciando objetos a través de otros, en este caso no se utilizó ya que no hay objetos compartidos, ni necesitás compararlos.


•	Cómo ayuda cada solución a aumentar la cohesión de los componentes.

La solución con observer aumenta la cohesión solo en las consignas del dominio que implican notificaciones (ya que para esto usamos observers), mas no así en el resto de ellas, ya que simplemente hubo que modificar el comportamiento en las clases en las que lo creímos necesario.
En el decorator sí se vé claramente el aumento de la cohesión ya que el comportamiento no se ve modificado directamente en la clase sino que se relaciona a ésta con otros objetos que agregan o modifican comportamiento (PartidoPosta no fue editado para cambiar su comportamiento sino que PartidoDecorator se encarga de, por ejemplo, da de baja a un participante).


--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


<h2>Entrega 3:</h2>

• Indique qué conceptos del diseño permitieron bajar el acoplamiento entre componentes. Justifique a partir de ejemplos concretos para cada concepto.

El jugador propone a un amigo, estando compuesta de el nombre, la edad, los amigos y el tipo de jugador que sería si es que lo aceptan. En caso que sea aceptado, el método cargarDatos() llena los datos del jugador en esta clase que estaba en la propuesta, para luego agregagarla a la lista de jugadores habilitados

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


<h2>Entrega 4:</h2>

Para el ordenamiento de los jugadores, de utiliza una interfaz Criterio que establece polimórficamente los criterios (handicap, promedio de calificaciones último partido, promedio calificaciones de los últimos n partidos y criterios compuestos, por el momento) que generaran una lista que decidimos llamar "puntajesCriterio", cuyos elementos los utilizará el sistema para ordenar a los participantes.

El hecho de que los criterios se puedan agregar como parte de una interfaz nos otorga la posibilidad de poder agregar más criterios a futuro: lo único que deben respetar estos es que generen un elemento en la lista puntajesCriterio. Esto implica cohesión y flexibilidad.

Para encarar los criterios compuestos utilizamos el patrón Composite que se vale del método determinarPuntajeCriterio() de los demás criterios para obtener el suyo.

Se implementa una clase para los algoritmos de division de equipos. Esta solucion permite delegar la responsabilidad del armado de equipos, aumenta la cohesion y la flexibilidad al existir la posibilidad de agregar otros algoritmos de division a futuro.

Se implementa un Command para separar el momento de generacion de equipos tentativos, del momento de confirmar equipos, lo cual aporta flexibilidad pues permite generar tantos equipos tentativos como se desee antes de confirmar los que jugaran.

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


<h2>Entrega 6:</h2>

Partimos del hecho que la aplicación a desarrollar está pensada para organizar partidos de fútbol  5 con miembros de una comunidad formada por aproximadamente 25 personas. Esto implica que la densidad de datos con la que trabaja el programa no es muy grande, ni tampoco la variación de los mismos. Además, los casos de uso contemplados en la aplicación son de acceso únicamente para el administrador, por lo que la misma no será de uso masivo (distinto sería si cualquier jugador pudiera acceder para darse de baja, por ejemplo).

La decisión de trabajar con Arena se basó en la magnitud de la aplicación: es relativamente pequeña, maneja pocos datos y tiene un único usuario, como se detalló arriba. Arena justamente utiliza una arquitectura centralizada y permite obtener interfaces de escritorio. El primer punto implica que el modelo y la vista se encuentran en el mismo lugar (la computadora del administrador, en este caso) y se justifica por la falta de necesidad de almacenar un gran número de datos o variadas funcionalidades en un servidor externo. Por otro lado, se decidió que la aplicación sea de escritorio porque es lo más simple y directo de manejar para el administrador.
