Feature: simple login

  Background: base config
    Given url 'https://0a7f00d6036d741a8001495a000b0071.web-security-academy.net/'
    * header Accept = 'application/json'
    * configure connectTimeout = 8000
    * configure readTimeout = 8000

  Scenario: simple login (expect 200)
    * def loginPayload = { username=argentina&password=nicole}
    Given path 'users/login'
    And request loginPayload