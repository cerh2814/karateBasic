Feature: Login via form

  Background:
    * url 'https://0aab0000034c07b9806076dd00d30023.web-security-academy.net'
    * header Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000
  Scenario: Login usando x-www-form-urlencoded (extrae csrf)
    Given path '/login'
    When method get
    Then status 200
    * def csrf = (response.match(/name="csrf" value="([^"]+)"/) ? response.match(/name="csrf" value="([^"]+)"/)[1] : 'PIKIFSDoTsYWU5lrGco9PfaygO149H')
    * header Content-Type = 'application/x-www-form-urlencoded'
    Given path '/login'
    And form field csrf = csrf
    And form field username = 'admin'
    And form field password = 'admin'
    When method post
    Then status 200
    * print responseHeaders
    * def csrf = (response.match(/name="csrf" value="([^"]+)"/) ? response.match(/name="csrf" value="([^"]+)"/)[1] : 'PIKIFSDoTsYWU5lrGco9PfaygO149H')
    * print 'csrf:', csrf



  Scenario: Login usando x-www-form-urlencoded (extrae csrf y hace POST)
    # 1) GET para obtener la página de login y extraer csrf
    Given path '/login'
    When method get
    Then status 200
    * def csrf = (response.match(/name="csrf" value="([^"]+)"/) ? response.match(/name="csrf" value="([^"]+)"/)[1] : 'PIKIFSDoTsYWU5lrGco9PfaygO149H')
    * print 'csrf:', csrf

    # asegurar que no haya Content-Type duplicado y no seguir redirects para capturar 302
    * remove header Content-Type
    * configure followRedirects = false

    # 2) POST usando form fields (Karate pone Content-Type automáticamente)
    Given path '/login'
    And form field csrf = csrf
    And form field username = 'wiener'
    And form field password = 'peter'
    When method post

    # debug
    * print 'responseStatus:', responseStatus
    * print 'responseHeaders (POST):', responseHeaders
    * print 'response body:', response

    # aceptar 302 o 200; fallar en otro caso
    * assert responseStatus == 302 || responseStatus == 200

    # extraer cookie si aplica
    * def setCookie = responseHeaders['Set-Cookie'] ? responseHeaders['Set-Cookie'][0] : null
    * print 'Set-Cookie:', setCookie

    # re-habilitar redirects para siguientes llamadas
    * configure followRedirects = true





