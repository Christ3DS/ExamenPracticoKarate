Feature: Realizar transferencia de saldo

Scenario: Transferir al receptor
  Given url urlTransacciones + '/v1/transfer'
  And header x-channel = 'WEB'
  And header Authorization = 'Bearer ' + token
  And header Content-Type = 'application/json'
  And request { recipientId: '#(idReceptor)', amount: '#(monto)', description: '#(nota)', categoryId: 'cat_inc_1' }
  When method post
  Then status 200
  And match response.status == 'COMPLETED'
  And match response.message == '#string'
  And match response.transactionId == '#string'
  And match response.referenceCode == '#string'
  * def transferencia = response
  * def codigoTransaccion = response.referenceCode
