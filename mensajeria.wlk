import mensajeros.*

object mensajeria {
    var property mensajeros = #{}
    var property paquetesEnviados = []

    method contratar(personaje){
        mensajeros.add(personaje)
    }

    method despedir(personaje) {
      mensajeros.remove(personaje)
    }

    method despedirATodos() {
      mensajeros.clear()
    }

    method esGrande() {
      return mensajeros.size() > 2
    }

    method paquetePuedeSerEntregadoPorPrimero() {
      return paquete.puedeSerEntregadoPor(self.primerMensajero())
    }

    method pesoUltimoMensajero() {
      return self.ultimoMensajero().peso()
    }

    method primerMensajero() {
      return mensajeros.asList().first()
    }

    method ultimoMensajero() {
      return mensajeros.asList().last()
    }

    method puedeEntregarPaquete(tipoDPaquete) {
      return mensajeros.any({mensajero => tipoDPaquete.puedeSerEntregadoPor(mensajero)})
    }

    method quienesPuedenEntregarPaquete(tipoDPaquete) {
      return mensajeros.filter({mensajero => tipoDPaquete.puedeSerEntregadoPor(mensajero)})
    }

    method promedioPeso() {
      return mensajeros.sum({mensajero => mensajero.peso()}) / mensajeros.size()
    }

    method enviarPaquete(tipoDPaquete) {
      if(mensajeros.any({mensajero => tipoDPaquete.puedeSerEntregadoPor(mensajero)})){
        paquetesEnviados.add(tipoDPaquete)

      }
      else{
        pendientes.agregarPaquetePendiente(tipoDPaquete)
      }
    }

    method facturacion() {
      return paquetesEnviados.sum({paquete => paquete.precio()})
    }

    method enviarPaquetes(_paquetes) {
      _paquetes.forEach({elemento => self.enviarPaquete(elemento)})
    }

}

object paquetito {
    var property pago = true
    var property destino = puente
    const property precio = 0

    method puedeSerEntregadoPor(personaje) {
      return self.destino().dejarPasar(personaje)
    }
}

object paqueton {
    var property pago = false
    var property precio = 100
    var property cantDestinos = 0
    var property destinos = []
    
    method nuevoDestino(destino) {
      destinos.add(destino)
      cantDestinos += 1
    }

    method estaPago() {
      return pago
    }

    method pagarTodo() {
      pago = true
    }

    method pagoParcial(pagado) {
      precio -= pagado
    }

    method puedeSerEntregadoPor(personaje) {
      return self.estaPago() and destinos.map({destino => destino.dejarPasar(personaje)})
    }
}

object pendientes {
  var property paquetes = []

  method agregarPaquetePendiente (tipoDPaquete) {
    paquetes.add(tipoDPaquete)
  }

   method paqueteMasCaro() {
    return paquetes.max({paquete => paquete.precio()})
   }

    method enviarPaqueteMasCaro() {
      mensajeria.enviarPaquete(self.paqueteMasCaro())
      paquetes.remove(self.paqueteMasCaro())
    }

}
