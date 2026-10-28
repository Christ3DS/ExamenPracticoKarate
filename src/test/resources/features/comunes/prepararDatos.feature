Feature: Preparar datos de la regresión

Scenario: Crear y fondear usuarios de prueba
  * def telefonoEmisor = generarTelefono()
  * def telefonoReceptor = generarTelefono()
  * assert telefonoEmisor != telefonoReceptor
  * def resultadoEmisor = call read('comunes/crearUsuario.feature') { telefono: '#(telefonoEmisor)', nombreCompleto: 'QA Emisor', correo: '#(telefonoEmisor + sufijoCorreo)', pin: '#(pinUsuario)' }
  * def resultadoReceptor = call read('comunes/crearUsuario.feature') { telefono: '#(telefonoReceptor)', nombreCompleto: 'QA Receptor', correo: '#(telefonoReceptor + sufijoCorreo)', pin: '#(pinUsuario)' }
  * def usuarioEmisor = resultadoEmisor.usuario
  * def usuarioReceptor = resultadoReceptor.usuario
  * def inicioAdministrador = call read('comunes/loginAdministrador.feature')
  * def tokenAdministrador = inicioAdministrador.token
  * def saldoAsignado = 1000
  * def fondeoEmisor = call read('comunes/asignarSaldo.feature') { idUsuario: '#(usuarioEmisor.id)', monto: '#(saldoAsignado)', saldoEsperado: '#(saldoAsignado)', tokenAdministrador: '#(tokenAdministrador)' }
  * def fondeoReceptor = call read('comunes/asignarSaldo.feature') { idUsuario: '#(usuarioReceptor.id)', monto: '#(saldoAsignado)', saldoEsperado: '#(saldoAsignado)', tokenAdministrador: '#(tokenAdministrador)' }
  * def saldoInicialEmisor = fondeoEmisor.saldoNuevo
  * def saldoInicialReceptor = fondeoReceptor.saldoNuevo
  * match saldoInicialEmisor == saldoAsignado
  * match saldoInicialReceptor == saldoAsignado
  * def inicioEmisor = call read('comunes/iniciarSesion.feature') { telefono: '#(usuarioEmisor.phone)', pin: '#(pinUsuario)' }
  * def tokenEmisor = inicioEmisor.token
  * def resultadoTransferencia = call read('comunes/realizarTransferencia.feature') { token: '#(tokenEmisor)', idReceptor: '#(usuarioReceptor.id)', monto: '#(montoTransferencia)', nota: '#(notaTransferencia)' }
  * def codigoTransaccion = resultadoTransferencia.codigoTransaccion
  * def saldoEmisor = call read('comunes/consultarSaldo.feature') { token: '#(tokenEmisor)' }
  * def saldoFinalEmisor = saldoEmisor.saldo
  * def inicioReceptor = call read('comunes/iniciarSesion.feature') { telefono: '#(usuarioReceptor.phone)', pin: '#(pinUsuario)' }
  * def tokenReceptor = inicioReceptor.token
  * def saldoReceptor = call read('comunes/consultarSaldo.feature') { token: '#(tokenReceptor)' }
  * def saldoFinalReceptor = saldoReceptor.saldo
  * def historialReceptor = call read('comunes/consultarTransacciones.feature') { token: '#(tokenReceptor)' }
  * def transaccionesRecibidas = karate.filter(historialReceptor.transacciones, function(x){ return x.referenceCode == codigoTransaccion; })
  * assert transaccionesRecibidas.length > 0
