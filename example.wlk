object paquete {
    var estaPago = false
    var destino = laMatrix
    method estaPago() = estaPago
    method pagarPaquete() {
        estaPago = true
    } 

    method puedeEntregarse(unMensajero){
        return
        destino.dejaPasar(unMensajero) &&
        self.estaPago()
    } 
    method precioTotal() = 50
}
object paquetito {
    method precioTotal() = 0 
    method estaPago() = true
    method puedeEntregarse(unMensajero) = true  
}

object paqueton {
    const destinos = []
    var importePagado = 0
    method agregarDestinos(unDestino) {
        destinos.add(unDestino)
    }
    method precioTotal() = 100 * destinos.size()

    method pagar(unImporte) { 
        importePagado = importePagado + unImporte
    }

    method estaPago() = importePagado >= self.precioTotal()

    method puedeEntregarse(unMensajero) {
        return 
        self.estaPago() && self.puedePasarPorDestino(unMensajero)
    }

    method puedePasarPorDestino(unMensajero) {
        return 
        destinos.all({d => d.dejaPasar(unMensajero)})
    } 
}

object puenteDeBrooklyn {
    method dejaPasar(unMensajero){
        return 
        unMensajero.peso() < 1000
    }
}

object laMatrix {
    method dejaPasar(unMensajero){
        return 
        unMensajero.puedeLlamar()
    }
}

object roberto {
    var transporte = bicicleta
    method cambiarTransporte(nuevoTransporte) {
        transporte = nuevoTransporte
    }
    method peso() = 90 + transporte.peso()
    method puedeLlamar() = false 
}

object chuckNorris {
    method peso() = 80 
    method puedeLlamar() = true
}

object neo {
    method peso() = 0    
    var tieneCredito = true
    method cargarCredito() {tieneCredito = true}
    method agotarCredito() {tieneCredito = false}
    method puedeLlamar() = tieneCredito 
}

object bicicleta {
    method peso() = 5 
}

object camion {
    var acoplados = 1
    method cantidadAcoplados(unaCantidad){
        acoplados = unaCantidad
    }
    method peso() = acoplados * 500  
}


object empresaMensajeria {
    const mensajeros = []
    const paquetesPendientes = []
    const paquetesEnviados = []
    method mensajeros() = mensajeros
    method contratar(unMensajero) {
        mensajeros.add(unMensajero)
    } 
    method despedir(unMensajero) {
        mensajeros.remove(unMensajero)
    }
    method esGrande() = mensajeros.size() > 2
    method puedeEntregarsePaquete() = paquete.puedeEntregarse(mensajeros.first()
    method pesoDelUltimoMensajero() = mensajeros.last().peso()
    method puedeEntregarse(unPaquete) {
        return 
        mensajeros.any({m => unPaquete.puedeEntregarse(m)})
    }
    method losQuePuedenEntregar(unPaquete) {
        return 
        mensajeros.filter({m => unPaquete.puedeEntregarse(m)})
    } 
    method tieneSobrePeso() = self.pesosDeLosMensajeros() / mensajeros.size() > 500
    method pesosDeLosMensajeros() = mensajeros.sum({m => m.peso()})
    method enviar(unPaquete) {
        if(self.puedeEntregarse(unPaquete)){
            paquetesEnviados.add(unPaquete)
        }
        else {
            paquetesPendientes.add(unPaquete)
        }
    }
    method facturacion() = paquetesEnviados.sum({p => p.precioTotal()}) 
    method enviarPaquetes(listaDePaquetes) {
        listaDePaquetes.forEach({p => self.enviar(p)})
    }
    method enviarPendienteMasCaro() {
        if(self.puedeEntregarse(self.paquetePendienteMasCaro())){
            self.enviar(self.paquetePendienteMasCaro())
            paquetesPendientes.remove(self.paquetePendienteMasCaro())
        }
    }
    method paquetePendienteMasCaro() = paquetesPendientes.max({p => p.precioTotal()})

}
