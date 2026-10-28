Feature: Asignar saldo administrativo

Scenario: Acreditar saldo inicial
  Given url urlAdministrador + '/v1/balance'
  And header x-channel = 'ADMIN'
  And header Authorization = 'Bearer ' + tokenAdministrador
  And header Content-Type = 'application/json'
  And request { userId: '#(idUsuario)', amount: '#(monto)', type: 'CREDIT', description: 'Preparación de pruebas' }
  When method post
  Then status 200
  And match response.success == true
  And match response.newBalance == saldoEsperado
  * def saldoNuevo = response.newBalance
