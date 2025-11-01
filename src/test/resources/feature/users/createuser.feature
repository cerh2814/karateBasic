Feature: crear usuario
  Background: define url y timeouts
    Given url 'https://conduit-api.bondaracademy.com'
    * header Accept = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario: create new user
    Given path 'api/users'
    When method Post
    # **AQUÍ CAMBIAMOS LOS DATOS PARA EVITAR DUPLICADOS**
    And request {"user":{"email":"trux002@test.com","password":"karate123","username":"trux002"}}
    # La línea 'def status = responseStatus' no es estrictamente necesaria para la prueba
    # **AQUÍ AGREGAMOS LA ASERSION DE 201**
    Then assert responseStatus == 201
    And print response