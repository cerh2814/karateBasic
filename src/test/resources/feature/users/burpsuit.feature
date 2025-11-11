Feature: ejemplos de endpoints in methods

  Background: configure base url y timeouts
    Given url 'https://petstore.swagger.io/v2'
    * header Accept = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario Outline: Register prestamype
    Given path '<endpoint>'
    When method <method>
    Then status <status>


    Examples:
      | endpoint | method | status |
      | user     | get    | 200    |