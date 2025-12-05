Feature: Account API Testing - demoqa.com

  Background:
    # 1. URL base
    * url 'https://demoqa.com/Account/v1'
    # 2. Credenciales únicas (buena práctica)
    * def uniqueUser = 'karateUser' + $karate.time.millis
    * def credentials = { "userName": "#(uniqueUser)", "password": "aaaa777@Bfa" }
    # 3. Variables para almacenar resultados globales del feature
    * def globalUserID = ''
    * def globalAuthToken = ''



  Scenario: 1. Crear Usuario y Almacenar ID
    Given path '/User'
    And request credentials
    When method POST
    Then status 201
    And match response.userID == '#notnull'
    * def globalUserID = response.userID # ➡️ Almacenamos el userID en la variable global
    * print 'Usuario ID Creado: ' + globalUserID



  Scenario: 2. Generar Token y Almacenar
    Given path '/GenerateToken'
    And request credentials
    When method POST
    Then status 200
    And match response.token == '#notnull'
    And match response.status == 'Success'
    And match response.result == 'User authorized successfully.'
    * def globalAuthToken = response.token # ➡️ Almacenamos el token en la variable global
    * print 'Token de Autenticación: ' + globalAuthToken



  Scenario: 3. Verificar Estado Autorizado del Usuario (Authorized)
    Given path '/Authorized'
    And request credentials
    # ⚠️ Aplicar Autenticación (aunque este endpoint no siempre lo requiere, es una buena práctica)
    * header Authorization = 'Bearer ' + globalAuthToken
    When method POST
    Then status 200


  Scenario: 4. ✅ GET /Account/v1/User/{UUID} (Consultar Usuario por userId)

    # 1. Verificar si tenemos el token y el ID para continuar
    * assert globalAuthToken != ''
    * assert globalUserID != ''

    # 2. 🛡️ Configurar el encabezado de Autenticación
    * header Authorization = 'Bearer ' + globalAuthToken # ➡️ USAR el token almacenado

    # 3. Configurar y ejecutar la petición
    Given path 'User', globalUserID # ➡️ USAR el ID almacenado
    When method GET
    Then status 200 # ➡️ El problema de 401 se resuelve con el encabezado

    # 4. Validaciones
    And match response.userID == globalUserID # Verificamos que se haya consultado el usuario correcto
    And match response.username == credentials.userName
    * print 'Usuario consultado:', response