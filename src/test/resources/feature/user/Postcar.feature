Feature: Registrar usuario vía API en Buggy Cars

  Background:
    # URL base y datos dinámicos
    Given url 'https://buggy.justtestit.org'
    * def uniqueUsername = 'apiuser' + (new java.util.Date()).getTime()
    * def firstName = 'Api'
    * def lastName = 'User'
    * def email = uniqueUsername + '@test.com'
    * def password = 'Password123!'
    * header Content-Type = 'application/json'

  Scenario: Registro exitoso de un nuevo usuario (API)
    Given path 'register'
    And request
      """
      {
        "username": "#(uniqueUsername)",
        "firstName": "#(firstName)",
        "lastName": "#(lastName)",
        "email": "#(email)",
        "password": "#(password)",
        "confirmPassword": "#(password)"
      }
      """
    * print 'Request body:' + request
    When method post
    * print 'Status:' + responseStatus
    * print 'Response:' + response
    Then assert responseStatus == 201 || responseStatus == 200
    And match response contains { username: '#(uniqueUsername)' }
    * print 'Usuario registrado:' + uniqueUsername
