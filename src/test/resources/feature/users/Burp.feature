Feature: Login via form (Postman -> Karate)

  Background:
    * url 'https://0a48002b04f9405581b70237007f009d.web-security-academy.net'
    * header Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario: Login usando x-www-form-urlencoded (extrae csrf)
    # 1) GET para obtener la página de login y extraer csrf si existe
    Given path '/login'
    When method get
    Then status 200

    # extrae csrf del HTML o usa el valor mostrado en Postman como fallback
    * def csrf = (response.match(/name="csrf" value="([^"]+)"/) ? response.match(/name="csrf" value="([^"]+)"/)[1] : 'PIKIFSDoTsYWU5lrGco9PfaygO149H')

    # 2) enviar login como form-url-encoded
    * header Content-Type = 'application/x-www-form-urlencoded'
    Given path '/login'
    And form field csrf = csrf
    And form field username = 'admin'
    And form field password = 'admin'
    When method post

    Then status 200

    # imprimir headers para ver cookies/redirects/debug
    * print responseHeaders
    * def csrf = (response.match(/name="csrf" value="([^"]+)"/) ? response.match(/name="csrf" value="([^"]+)"/)[1] : 'PIKIFSDoTsYWU5lrGco9PfaygO149H')
    * print 'csrf:', csrf
