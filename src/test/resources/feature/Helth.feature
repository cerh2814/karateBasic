Feature: Prueba Health - mejorado

  Background:
    * url 'https://practice.expandtesting.com/notes'

  # health-check simple
  Scenario: Verificar respuesta health-check
    Given path 'api/health-check'
    When method GET
    Then status 200
    And match response.status == 200
    And match response.message == 'Notes API is Running'

  # registro (acepta 201 o 409 si ya existe)
  Scenario: Registrar usuario (idempotente)
    * def user = { name: 'devtest', email: 'devtest@yopmail.com', password: 'Test@1234' }
    * def registerPayload = 'name=' + karate.urlEncode(user.name) + '&email=' + karate.urlEncode(user.email) + '&password=' + karate.urlEncode(user.password)
    Given path 'api/users/register'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And request registerPayload
    When method POST
    Then status 201
    * assert responseStatus == 201 || responseStatus == 409
    * if (responseStatus == 201) karate.log('Usuario creado:', user.email) else karate.log('Usuario ya existe:', user.email)

  # login una sola vez y almacenar token para escenarios siguientes
  Scenario: Login y obtener token
    * def creds = { email: 'ana@yopmail.com', password: '781@weReee' }
    * def loginPayload = 'email=' + karate.urlEncode(creds.email) + '&password=' + karate.urlEncode(creds.password)
    Given path 'api/users/login'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'application/json'
    And request loginPayload
    When method POST
    Then status 200
    And match response.success == true
    And match response.message == 'Login successful'
    * def token = response.data.token
    * print 'token:', token
    * configure headers = { Accept: 'application/json' }   # default headers para siguientes llamadas
    * karate.set('authToken', token)
  Scenario: Obtener profile con x-auth-token
    * def creds = { email: 'ana@yopmail.com', password: '781@weReee' }
    * def loginPayload = 'email=' + karate.urlEncode(creds.email) + '&password=' + karate.urlEncode(creds.password)
    Given path 'api/users/login'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'application/json'
    And request loginPayload
    When method POST
    Then status 200
    And match response.success == true
    And match response.message == 'Login successful'
    * def token = response.data.token
    * print 'token:', token
    * configure headers = { Accept: 'application/json' }   # default headers para siguientes llamadas
    * karate.set('authToken', token)
    Given path 'api/users/profile'
    And header Content-Type = 'application/json'
    And header x-auth-token = authToken
    When method GET
    Then status 200
    And match response.success == true
  Scenario: Actualizar profile y validar respuesta
    * def creds = { email: 'ana@yopmail.com', password: '781@weReee' }
    * def loginPayload = 'email=' + karate.urlEncode(creds.email) + '&password=' + karate.urlEncode(creds.password)
    Given path 'api/users/login'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'application/json'
    And request loginPayload
    When method POST
    Then status 200
    And match response.success == true
    And match response.message == 'Login successful'
    * def token = response.data.token
    * print 'token:', token
    Given path 'api/users/profile'
    And header x-auth-token = token
    * karate.set('authToken', token)
    * def updateData = { name: 'anaxx', phone: '781977772', company: 'test111' }
    And request updateData
    When method PATCH
    Then status 200
    And match response.success == true
    * match response.data.id != null
    * match response.data.company == 'test111'
    * match response.data.phone == '#regex \\d{4,15}'
    * print 'Perfil actualizado para el usuario ID:', response.data.id

  Scenario: Actualizar profile y validar name actualizado
    * def creds = { email: 'ana@yopmail.com', password: '781@weReee' }
    * def loginPayload = 'email=' + karate.urlEncode(creds.email) + '&password=' + karate.urlEncode(creds.password)
    Given path 'api/users/login'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'application/json'
    And request loginPayload
    When method POST
    Then status 200
    And match response.success == true
    And match response.message == 'Login successful'
    * def token = response.data.token
    * print 'token:', token
    Given path 'api/users/profile'
    And header x-auth-token = token
    * karate.set('authToken', token)
    * def updateData = { name: 'anaxx', phone: '781977772', company: 'test111' }
    And request updateData
    When method PATCH
    Then status 200
    And match response.success == true
    * match response.data.id != null
    # validar el campo de respuesta (mínimo 5 caracteres, solo letras y espacios)
    * match response.data.name == '#regex ^[\\p{L}\\s]{3,}$'
    * match updateData.name == '#regex ^[\\p{L}\\s]{4,}$'

