@regresion
Feature: Regresión de Transferencias

Background:
  * url urlBase
  * def pinUsuario = '123456'
  * def sufijoCorreo = '@qa-karate.test'
  * def montoTransferencia = 450.00
  * def notaTransferencia = 'Pago de Servicios'
  * def datosPrueba = callonce read('comunes/prepararDatos.feature')
  * def usuarioEmisor = datosPrueba.usuarioEmisor
  * def usuarioReceptor = datosPrueba.usuarioReceptor
  * def saldoInicialEmisor = datosPrueba.saldoInicialEmisor
  * def saldoInicialReceptor = datosPrueba.saldoInicialReceptor
  * def codigoTransaccion = datosPrueba.codigoTransaccion

@usuarios
Scenario: Registro de Usuarios Emisor y Receptor
  * karate.set('usuarioEmisor', usuarioEmisor)
  * karate.set('usuarioReceptor', usuarioReceptor)
  * karate.set('saldoInicialEmisor', saldoInicialEmisor)
  * karate.set('saldoInicialReceptor', saldoInicialReceptor)
  * match usuarioEmisor contains { id: '#string', phone: '#string', status: 'ACTIVE' }
  * match usuarioReceptor contains { id: '#string', phone: '#string', status: 'ACTIVE' }
  * assert usuarioEmisor.phone != usuarioReceptor.phone
  * match saldoInicialEmisor == 1000
  * match saldoInicialReceptor == 1000

@transferencia
Scenario: Transferencia del Usuario Emisor al Receptor
  * def inicioEmisor = call read('comunes/iniciarSesion.feature') { telefono: '#(usuarioEmisor.phone)', pin: '#(pinUsuario)' }
  * def tokenEmisor = inicioEmisor.token
  * karate.set('tokenEmisor', tokenEmisor)
  * match tokenEmisor == '#string'
  * karate.set('codigoTransaccion', codigoTransaccion)
  * match codigoTransaccion == '#string'
  * match datosPrueba.resultadoTransferencia.transferencia.status == 'COMPLETED'
  * match datosPrueba.resultadoTransferencia.transferencia.message contains 'Transferencia'
  * def saldoFinalEmisor = datosPrueba.saldoFinalEmisor
  * karate.set('saldoFinalEmisor', saldoFinalEmisor)
  * match saldoFinalEmisor == saldoInicialEmisor - montoTransferencia
  * assert saldoFinalEmisor == 550

@receptor
Scenario: Validación de Transferencia en Receptor
  * def inicioReceptor = call read('comunes/iniciarSesion.feature') { telefono: '#(usuarioReceptor.phone)', pin: '#(pinUsuario)' }
  * def tokenReceptor = inicioReceptor.token
  * karate.set('tokenReceptor', tokenReceptor)
  * match tokenReceptor == '#string'
  * def saldoFinalReceptor = datosPrueba.saldoFinalReceptor
  * karate.set('saldoFinalReceptor', saldoFinalReceptor)
  * match saldoFinalReceptor == saldoInicialReceptor + montoTransferencia
  * assert saldoFinalReceptor == 1450
  * def transaccionesRecibidas = datosPrueba.transaccionesRecibidas
  * assert transaccionesRecibidas.length > 0
  * match transaccionesRecibidas[0].amount == montoTransferencia
  * match transaccionesRecibidas[0].description contains notaTransferencia
  * match transaccionesRecibidas[0].referenceCode == codigoTransaccion
  * def auditoriaAdministrador = call read('administrador.feature') { codigoObjetivo: '#(codigoTransaccion)', idEmisorEsperado: '#(usuarioEmisor.id)', idReceptorEsperado: '#(usuarioReceptor.id)', telefonoEmisorEsperado: '#(usuarioEmisor.phone)', telefonoReceptorEsperado: '#(usuarioReceptor.phone)' }
  * assert auditoriaAdministrador.transferencias.length > 0
