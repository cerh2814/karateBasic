Feature: Delete product
  Background: configure base url y timeouts
    Given url 'https://fakestoreapi.com'
    * header Accept = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario: delete product
    Given path 'products/6'
    When method delete
    Then status 200
    And print response