Feature: Inicio de sesión de usuario

Scenario: Iniciar sesión
  Given url urlAutenticacion + '/v1/login'
  And header x-channel = 'WEB'
  And header Content-Type = 'application/json'
  And request { phone: '#(telefono)', pin: '#(pin)' }
  When method post
  Then status 200
  And match response.token == '#string'
  And match response.user.id == '#string'
  * def token = response.token
  * def usuario = response.user
