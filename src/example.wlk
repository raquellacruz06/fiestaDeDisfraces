class Fiesta {
	const lugar
	const property fecha
	var invitados = #{}
	method esUnBodrio() = invitados.all({invitado=>!invitado.conformeConDisfraz()})
	method mejorDisfraz() = invitados.max({invitado=>invitado.disfraz().puntuacionTotal()})
	method condicionParaIntercambiarDisfraces(persona1,persona2) = self.estaEnFiesta(persona1,persona2) 
		and self.algunoDisconformeConDisfraz(persona1,persona2) 
			and self.estanAmbosConformes(persona1,persona2)
		
	method estaEnFiesta(persona1,persona2)= invitados.contains(persona1) and invitados.contains(persona2)
	
	method algunoDisconformeConDisfraz(persona1,persona2)= 			//asumimos que esta bien si los dos estan disconformes con el disfraz actual
		!(self.ambosConformes(persona1,persona2))

	method estanAmbosConformes(persona1,persona2){
		self.cambiarDisfraz(persona1,persona2) 
		return self.ambosConformes(persona1,persona2)
	}
	method cambiarDisfraz(persona1,persona2){
		persona1.cambiarDisfrazDeAUno(persona2.disfraz()) 
			persona2.cambiarDisfrazDeAUno(persona1.disfraz())
	}
	method ambosConformes(persona1,persona2) = persona1.conformeConDisfraz() and persona2.conformeConDisfraz()
	method intercambiarDisfraz(persona1,persona2) {
		if(!self. condicionParaIntercambiarDisfraces(persona1,persona2)){
			self.error("No pueden cambiar disfraces")
		}self.cambiarDisfraz(persona1,persona2)
	}
	method agregarInvitado(persona){
		if(invitados.contains(persona)){
			self.error("Ya esta en la fiesta")
			}invitados.add(persona)
	}
	method condicionParaFiestaInolvidable(persona)= persona.eresSexy() and persona.conformeConDisfraz()
	method fiestaInolvidable() = invitados.all({invitado =>self.condicionParaFiestaInolvidable(invitado)})
}

class Invitado{
	var property disfraz 
	var property edad
	var personalidad 
	var property fiesta
	method eresSexy() = personalidad.sosSecsi(self) 
	method conformeConDisfraz() = disfraz.puntuacionTotal() > 10
	method cambiarDisfrazDeAUno(disfrazNuevo){
		disfraz = disfrazNuevo
	}
}

class Disfraz{
	const nombre
	const fechaConfeccion
	var property personaQueLoUtiliza
	const caracteristicas = []
	method puntuaciones() = caracteristicas.forEach({carac => carac.puntuacion(self,personaQueLoUtiliza.fiesta())})
	method puntuacionTotal() = self.puntuaciones().sum()
	method tieneNombrePar()  = nombre.size() %2 == 0
	method tiempoDeRealizacion() {									//Quizas repeticion logica
		return self.fechaDeConfeccion() - personaQueLoUtiliza.fiesta().fecha())
	}
}

class Gracioso{
	var property nivelGracia
		method puntuacion(disfraz,fiesta) {
			if(disfraz.personaQueLoUtiliza().edad()>50){
				return self.nivelGracia()*3
			}else return self.nivelGracia()
		}  	
}

class Tobaras{
	var fechaDeAdquisicion
	method puntuacion(disfraz,fiesta){
		if( self.cumpleConTiempoFiesta(disfraz,fiesta) ){
			return 5
		}else return 3
	}
	method cumpleConTiempoFiesta(disfraz,fiesta) = self.fechaAdquisicion - fiesta.fecha()>= 2
			
}

object mickeyMousse{
	method valor() = 8
}
object osoCarolina{
	method valor() = 6	
}

class Caretas{
	const personaje
	method puntuacion(disfraz,fiesta) = personaje.valor()
	
}

class Sexy{
	method puntuacion(disfraz,fiesta){
		if(disfraz.personaQueLoUtiliza().eresSexy()){				//CREAR DESPUES ERESSEXY()
			return 15
		}else return 2
	}
}

object alegre{
	method sosSecsi(persona) = false
}

object taciturna{

	method sosSecsi(persona) = persona.edad() < 30
}
																	//HACER LA TERCER PERSONALIDAD

class Caprichoso inherits Invitado{					//REPETICION LOGICA
	override method conformeConDisfraz() = super () and disfraz.tieneNombrePar()
	
}

class Pretensioso inherits Invitado{				//REPETICION LOGICA
	override method conformeConDisfraz() = super() and disfraz.tiempoDeRealizacion() < 30

}

class Numerologos inherits Invitado{
	var puntajeEsperado
	override method conformeConDisfraz() = disfraz.puntuacionTotal() == puntajeEsperado
}