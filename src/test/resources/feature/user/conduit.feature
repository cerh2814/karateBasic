Feature: Registrar usuario en Buggy

  Background: url base y datos dinámicos
    Given url 'https://buggy.justtestit.org'
    * def username = 'apiuser' + (new java.util.Date()).getTime()
    * def firstName = 'Test'
    * def lastName = 'User'
    * def email = username + '@test.com'
    * def password = 'Password123!'
    * header Content-Type = 'application/json'

  Scenario: Registrar usuario correctamente (con debug)
    Given path 'register'
    And request
      """
      {
        "username": "#(username)",
        "firstName": "#(firstName)",
        "lastName": "#(lastName)",
        "email": "#(email)",
        "password": "#(password)",
        "confirmPassword": "#(password)"
      }
      """
    When method post
    Then print 'Status:' + responseStatus
    And print 'Response:' + response
    Then assert responseStatus == 201 || responseStatus == 200
    And match response contains { username: '#(username)' }
    And print 'Usuario registrado: ' + username
