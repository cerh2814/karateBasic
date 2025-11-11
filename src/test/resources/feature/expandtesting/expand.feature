Feature: examples expand

  Background: configure base url y timeouts
    Given url 'https://practice.expandtesting.com/'
    * header Accept = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario Outline: Examples de endpoints in methods
    #* def payload = { id: 6, username: 'pepe', firstName: 'pepe', lastName: 'pepe', email: 'pepe@yopmail.com', password: '78178.gC', phone: '777777', userStatus: 0 }
    Given path '<endpoint>'
   # And request payload
    When method <method>
    Then status <status>
    And print response
    * match response.success == true
    * match response.status == 200
    * match response.message contains 'Notes API is Running'

    Examples:
      | endpoint               | method | status |
      | notes/api/health-check | get    | 200    |