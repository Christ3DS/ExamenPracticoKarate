Feature: Crear usuario de billetera

Scenario: Registrar usuario nuevo
  Given url urlAutenticacion + '/v1/register'
  And header x-channel = 'WEB'
  And header Content-Type = 'application/json'
  And request { phone: '#(telefono)', fullName: '#(nombreCompleto)', email: '#(correo)', pin: '#(pin)' }
  When method post
  Then status 201
  And match response.message == 'Usuario creado exitosamente'
  And match response.user.id == '#string'
  And match response.user.phone == telefono
  And match response.user.status == 'ACTIVE'
  * def usuario = response.user
