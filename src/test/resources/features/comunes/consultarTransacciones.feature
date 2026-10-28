Feature: Consultar transacciones

Scenario: Consultar historial
  Given url urlBilletera + '/v1/transactions'
  And header x-channel = 'WEB'
  And header Authorization = 'Bearer ' + token
  When method get
  Then status 200
  And match response == '#[]'
  * def transacciones = response
