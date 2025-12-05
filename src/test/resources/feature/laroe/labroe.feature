##Feature: ingresar a la plataforma labroe
##
##  Background: configurar url base y timeouts
##    Given url 'https://www.labroe.com'
##    * header Accept = 'application/json'
##    * configure connectTimeout = 30000
##    * configure readTimeout = 30000
##    * configure ssl = true
##    * configure followRedirects = true
##
##  Scenario Outline: Acceder a endpoints y validar status
##    When method <method>
##    Then status <status>
##    * print 'response:', response
##    Examples:
##      | method | status |
##      | get    | 200    |
#
#Feature: ingresar a la plataforma labroe
#
#  Background: configurar url base y timeouts
#    # permitir pasar -DbaseUrl desde Maven/IDE (sin slash final)
#    * def baseUrl = karate.properties['baseUrl'] ? karate.properties['baseUrl'] : 'https://www.labroe.com'
#    * url baseUrl
#    * header Accept = 'application/json'
#    * header Content-Type = 'application/json'
#    * configure connectTimeout = 30000
#    * configure readTimeout = 30000
#    * configure ssl = true
#    * configure followRedirects = true
#
#  Scenario: Login y obtener token
#    # credenciales por -Dusuario/-Dclave o por defecto
#    * def usuario = karate.properties['usuario'] ? karate.properties['usuario'] : '44624979'
#    * def clave = karate.properties['clave'] ? karate.properties['clave'] : '44624979'
#    * def user = { usuario: usuario, clave: clave, tipoAutenticacion: 1, autorizacionDatosPersonales: true }
#
#    Given path 'login'
#    And request user
#    When method post
#    Then status 201
#    And print 'login response:', response
#
#    # extraer token de rutas comunes (ajusta según la respuesta real)
#    * def accessToken = response.authResult && response.authResult.accessToken ? response.authResult.accessToken : (response.token ? response.token : (response.accessToken ? response.accessToken : null))
#    * match accessToken != null
#    * header Authorization = 'Bearer ' + accessToken
#    * print 'accessToken:', accessToken
#
#  Scenario Outline: Llamada protegida con token
#    Given path <endpoint>
#    When method <method>
#    Then status <status>
#    And print 'response for', <endpoint>, ':', response
#
#    Examples:
#      | endpoint        | method | status |
#      | 'api','v1','me' | get    | 200    |
#      | ''              | get    | 200    |
#
#  Scenario: Login y obtener token (mejorado)
#    * configure retry = { count: 3, interval: 1500 }
#  # credenciales por -Dusuario/-Dclave o por defecto
#    * def usuario = karate.properties['usuario'] ? karate.properties['usuario'] : '44624979'
#    * def clave = karate.properties['clave'] ? karate.properties['clave'] : '44624979'
#    * def user = { usuario: usuario, clave: clave, tipoAutenticacion: 1, autorizacionDatosPersonales: true }
#
#  # apuntar al endpoint correcto (ej: v1/auth/patient) en lugar de /login si el servidor lo expone ahí
#    Given path 'v1','auth','patient'
#    And header Content-Type = 'application/json'
#    And header Accept = 'application/json'
#    And request user
#    When method post
#    And print 'request body:', user
#    And print 'response status:', responseStatus
#    And print 'response headers:', responseHeaders
#    And print 'response body:', response
#
#  # manejar respuesta inválida (405) con mensaje claro
#    * if (responseStatus == 405) karate.fail('405 Method Not Allowed en ' + baseUrl + '/v1/auth/patient -> revisar URL/método/headers')
#
#  # aceptar 200 o 201 como OK
#    * assert responseStatus == 200 || responseStatus == 201
#
#  # extracción robusta del token
#    * def accessToken = (response.authResult && response.authResult.accessToken) ? response.authResult.accessToken : (response.token ? response.token : (response.accessToken ? response.accessToken : null))
#    * if (!accessToken) karate.fail('Fallo: accessToken no encontrado en la respuesta de login (ver response)')
#    * header Authorization = 'Bearer ' + accessToken
#    * print 'accessToken:', accessToken


Feature: Prueba de autenticacion de paciente

  Background:
    # Definir la URL base una sola vez
    * url 'https://gw.api.pacificosegurossalud.com.pe/un-gestion-monolito-roe/wroe'

  Scenario: Autenticar un paciente exitosamente y obtener el token

    # 1. Definir los datos de la solicitud (Body)
    * form field usuario = '44624979'
    * form field clave = '44624979'
    * form field tipoAutenticacion = '1'
    * form field autorizacionDatosPersonales = 'true'

    * method post

    # 3. Validaciones de la Respuesta

    # a. Validar el Status Code HTTP
    * status 201

    # b. Validar campos específicos del JSON de respuesta
    # (Basado en el JSON que se muestra en la imagen de Postman)
    * match response.statusCode == 201
    * match response.success == true
    * match response.message == 'login exitoso. MFA no requerido.'
    * match response.isNewUser == false
    * match response.requireMfa == false

    # c. Validar la existencia de campos dentro de 'user' y 'authResult'
    * match response.user.userId == '#string'
    * match response.user.email == '#string'
    * match response.authResult.token == '#string'
    * match response.authResult.requireMfa == false

    # 4. (Opcional) Almacenar el token para usarlo en otras peticiones
    * def authToken = response.authResult.token

    # Puedes imprimir el token para verificarlo en la consola
    * print 'Token de Autenticación:', authToken



