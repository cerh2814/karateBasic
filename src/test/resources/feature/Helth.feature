Feature: Prueba Health

  Background:

    * url 'https://practice.expandtesting.com/notes'

  Scenario: Verificar respuesta de token ReCaptcha invalido
    Given path 'api/health-check'
    When method GET
    Then status 200
    And match response.status == 200
    And match response.message == 'Notes API is Running'
