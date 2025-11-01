Feature: Create new user in car

  Background: define url
    Given url 'https://buggy.justtestit.org/'

  Scenario: create new user
    Given path 'register'
    When method post
    Then status 201
    And match response.message == 'User created successfully'