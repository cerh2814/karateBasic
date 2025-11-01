Feature: Consulta de usuario en ReqRes

  Background: define url
    Given url 'https://reqres.in'

  Scenario: Obtener usuario por id
    Given path 'api/users', '2'
    When method get
    Then status 200
    And match response.data.first_name != 'emma.wong@reqres.in'
    And match response.data.id == 2
    And match response.data.first_name == 'Janet'
    And match response.data.last_name == 'Weaver'
