Feature: Consultar saldo

Scenario: Consultar saldo autenticado
  Given url urlBilletera + '/v1/balance'
  And header x-channel = 'WEB'
  And header Authorization = 'Bearer ' + token
  When method get
  Then status 200
  And match response.balance == '#number'
  And match response.currency == 'USD'
  * def saldo = response.balance
