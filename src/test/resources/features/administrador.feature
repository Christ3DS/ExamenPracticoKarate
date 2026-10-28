@administrador
Feature: Validación de operaciones por Administrador

Background:
  * url urlBase

Scenario: Validar la operación generada por el Emisor
  * def inicio = call read('comunes/loginAdministrador.feature')
  * def tokenAdministrador = inicio.token
  Given url urlAdministrador + '/v1/transactions'
  And header x-channel = 'ADMIN'
  And header Authorization = 'Bearer ' + tokenAdministrador
  When method get
  Then status 200
  And match response == '#[]'
  * def transferencias = karate.filter(response, function(x){ return x.referenceCode == codigoObjetivo && x.amount == 450; })
  * assert transferencias.length > 0
  * def enviada = karate.filter(transferencias, function(x){ return x.type == 'EXPENSE'; })
  * def recibida = karate.filter(transferencias, function(x){ return x.type == 'INCOME'; })
  * assert enviada.length > 0
  * assert recibida.length > 0
  * match enviada[0].amount == 450
  * match enviada[0].description contains 'Pago de Servicios'
  * match enviada[0].userId == idEmisorEsperado
  * match enviada[0].counterpartyPhone == telefonoReceptorEsperado
  * match recibida[0].description contains 'Pago de Servicios'
  * match recibida[0].userId == idReceptorEsperado
  * match recibida[0].counterpartyPhone == telefonoEmisorEsperado
  * match transferencias[0].id == '#string'
