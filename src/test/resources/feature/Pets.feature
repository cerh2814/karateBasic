Feature: ejemplos de endpoints in methods

  Background: configure base url y timeouts
    Given url 'https://petstore.swagger.io/v2'
    * header Accept = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario Outline: Examples de endpoints in methods
    * def payload = { id: 6, username: 'pepe', firstName: 'pepe', lastName: 'pepe', email: 'pepe@yopmail.com', password: '78178.gC', phone: '777777', userStatus: 0 }
    Given path '<endpoint>'
    And request payload
    When method <method>
    Then status <status>
    And print response

    Examples:
      | endpoint | method | status |
      | user     | post   | 200    |

  Scenario Outline: consulta de usuario por username
    Given path '<endpoint>'
    When method <method>
    Then status <status>
    And print response

    Examples:
      | endpoint  | method | status |
      | user/pepe | get    | 200    |


  Scenario Outline: update username
    * def payload = { username: 'pepexw', firstName: 'pepexw', lastName: 'pepexw', email: 'pepex@yopmail.com', password: '78178.gC', phone: '777777' }
    Given path '<endpoint>'
    And request payload
    When method <method>
    Then status <status>
    And print response


    Examples:
      | endpoint   | method | status |
      | /user/pepe | put    | 200    |


  Scenario Outline: loguin user
    Given path '<endpoint>'
    * def username = 'pepe'
    * def password = '78178.gC'
    When method <method>
    Then status <status>
    And print response
    * match response.message contains 'logged in user session'

    Examples:
      | endpoint   | method | status |
      | user/login | get    | 200    |

  Scenario Outline: loguin user
    Given path '<endpoint>'
    * def username = 'pepe'
    * def password = '78178.gC'
    When method <method>
    Then status <status>
    And print response
    * match response.message contains 'logged in user session'

    Examples:
      | endpoint  | method | status |
      | user/login | get    | 200    |

  Scenario Outline: logout user
    Given path '<endpoint>'
    When method <method>
    Then status <status>
    And print response

    Examples:
      | endpoint    | method | status |
      | user/logout | get    | 200    |


  Scenario Outline: Store order
    * def payload = { "id": 20, "petId": 1,"quantity": 11, "shipDate": "2025-11-01T01:53:48.927Z","status": "placed","complete": true}
    Given path '<endpoint>'
    And request payload
    When method <method>
    Then status <status>
    And print response
    * match response contains { "id": "#number", "petId": "#number", "status": "placed" }

    Examples:
      | endpoint    | method | status |
      | store/order | post   | 200    |


