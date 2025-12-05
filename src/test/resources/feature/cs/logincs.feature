Feature: Autenticacion y uso de token

  Background: configurar base url y timeouts
    Given url 'https://api.test.cambioseguro.com/api/v1.1/'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario Outline: Login y obtener token
    Given path '<endpoint>'
    And request { "phone": "911111222","email": "test22@yopmail.com","password": "abc123M","account_type": "Natural","company_discovery_source": "discovery_option_2","registration_source": "WEB-CREAR CUENTA-PN", }
    When method  <method>
    Then status <status>
    * print 'response:', response
    * match response.token != null
    * def authToken = response.token
    * header Authorization = 'Bearer ' + authToken

    Examples:
      | endpoint | method | status |
      | client   | post   | 400    |

#  Scenario: Usar token en siguiente llamada
#    Given path 'alguno_otro_endpoint'
#    And request { /* payload para siguiente endpoint */ }
#    When method post
#    Then status 200
#    * print 'response con auth:', response
