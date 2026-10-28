Feature: Inicio de sesión de Administrador

Scenario: Autenticar administrador
  Given url urlAdministrador + '/v1/login'
  And header x-channel = 'ADMIN'
  And header Content-Type = 'application/json'
  And request { username: 'admin', password: 'superpassword' }
  When method post
  Then status 200
  And match response.token == '#string'
  And match response.type == 'Bearer'
  * def token = response.token
