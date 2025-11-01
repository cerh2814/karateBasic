Feature: New de producto en FakeStoreAPI

  Background: define url y timeouts
    Given url 'https://fakestoreapi.com'
    * header Accept = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario: create new product
    Given path 'products/2'
    When method put
    And request {"title": "Rice fish", "price": 39.99}
    Then assert responseStatus == 201 || responseStatus == 200
    And print response
    And match response.id == 2