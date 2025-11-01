
Feature: test for the homepage

  Background: Define url
    Given url 'https://conduit-api.bondaracademy.com/api/'


  Scenario: Get all endpoints
    #Given url 'https://conduit-api.bondaracademy.com/api/
    Given path 'tags'
    When method get
    Then status 200
    And match response.tags contains ['Test', 'Git']
    And match response.tags !contains 'trucks'
    And match response.tags == '#array'
    And match each response.tags == '#string'

    #no combinar atajos



  Scenario: Get 10 articles from the page
    #Given url `https://conduit-api.bondaracademy.com/api/`
    And params { limit: 10, offset: 0 }
    Given path 'articles'
    When method get
    Then status 200
    And match response.articles == '#[10]'
    #no combinar atajos


