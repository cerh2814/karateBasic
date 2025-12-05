Feature: Pet Store API - CRUD Operations
  Background:
    * url 'https://petstore3.swagger.io/api/v3'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
  Scenario Outline: Create a new pet successfully
    * def requestBody =
      """
      {
        "id": 10,
        "name": "doggie",
        "category": {
          "id": 0,
          "name": "Dogs"
        },
        "photoUrls": [
          "string"
        ],
        "tags": [
          {
            "id": 1,
            "name": "love"
          }
        ],
        "status": "available"
      }
      """
    Given path '<endpoint>'
    And request requestBody
    When method <method>
    Then status <status>
    And match response.category.id == 0
    And match response.category.name != 'Dogssss'
    And match response.id == 10
    And match response.name == 'doggie'
    And match response.status == 'available'

    Examples:
      | endpoint | method | status |
      | /pet     | POST   | 200    |