Feature: validate the login functionality

  Scenario: get example
    Given url "https://api.restful-api.dev/objects"
    When method get
    Then status 200
