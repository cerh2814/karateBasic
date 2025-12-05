
Feature: Broken Login Basico Outline

  Background:
    * url 'https://0a5800ee034565a881852f35003a00e1.web-security-academy.net
    * configure headers = { Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' }
    * configure connectTimeout = 30000
    * configure readTimeout = 30000
    * configure followRedirects = true

  Scenario Outline: Broken Login Basico
    * url 'https://0a5800ee034565a881852f35003a00e1.web-security-academy.net'
    * configure headers = { Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' }
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

    * header Content-Type = 'application/x-www-form-urlencoded'

    And form field username = '<username>'
    Given path '/forgot-password'
    When method post
    Then status 200
    * print responseHeaders

    Examples:
      | username  | password |
      | affiliate | 2000     |
      | wiener    | peter    |


