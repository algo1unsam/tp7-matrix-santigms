object puente {
    method dejarPasar(personaje) {
      return personaje.peso() <= 1000
    }
}

object matrix {
  method dejarPasar(personaje) {
    return personaje.puedeLlamar()
  }
}

object camion {
    var property acoplados = 1

    method acoplados(cantidad) {
      acoplados = cantidad
    }

    method peso() {
      return acoplados * 500
    }

}

object monopatin {
    const property peso = 1
}

object paquete {
    var property pago = false
    var property destino = puente
    const property precio = 50

    method estaPago() {
      return pago
    }

    method pagar() {
      pago = true
    }

    method puedeSerEntregadoPor(personaje) {
      return self.destino().dejarPasar(personaje) && self.estaPago()
    }
}

object morfeo {
    const pesoBase = 90
    var property transporte = camion
    var property credito = false

    method peso() {
    return self.transporte().peso() + pesoBase
    }

    method puedeLlamar() {
      return credito
    }
}

object neo {
    var property transporte = camion
    var property peso = 0
    var property credito = false

    method puedeLlamar() {
      return credito
    }
}

object trinity {
  const property peso = 900
  const property credito = true

  method puedeLlamar() {
    return credito
  }
}



