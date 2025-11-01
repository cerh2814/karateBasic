Feature: Account API Testing - demoqa.com

  Background:

    * url 'https://demoqa.com/Account/v1'
    * def credentials = { "userName": "taassedxsa", "password": "aaaa777@Bfa" }
   # * configure ssl = true # Útil si encuentras problemas con certificados

  Scenario: 1. Obtener Información de Usuario (User)

    Given path '/User'
    And request credentials
    When method POST
    Then status 201
    # Validación de los campos clave de la respuesta
    And match response.userID == '#notnull'
    And match response.username == credentials.userName
    And match response.books == []
    * print 'Usuario ID: ' + response.userID
    * print 'Nombre de Usuario: ' + response.username

  Scenario: 2. Generar Token para Autenticación (GenerateToken)
    Given path '/GenerateToken'
    And request credentials
    When method POST
    Then status 200
    # Validación de la respuesta (verificando que existan los campos clave y el mensaje)
    And match response.token == '#notnull'
    And match response.expires == '#notnull'
    And match response.status == 'Success'
    And match response.result == 'User authorized successfully.'
    # Almacenar el token para usarlo en el siguiente escenario
    * def authToken = response.token
    * print 'Token de Autenticación: ' + authToken

  Scenario: 3. Verificar Estado Autorizado del Usuario (Authorized)
    # Se reusa la URL base y las credenciales del Background
    Given path '/Authorized'
    And request credentials
    When method POST
    Then status 200






