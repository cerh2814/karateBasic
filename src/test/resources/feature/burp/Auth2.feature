#Feature: Login basico
#  Background:
#    * url 'https://0a4600cd03f53c898206f13500b400fa.web-security-academy.net'
#    * configure headers = { Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' }
#    * configure connectTimeout = 5000
#    * configure readTimeout = 5000
#    #autentificacion basica
#
#  Scenario: Login usando x-www-form-urlencoded
#    And form field username = 'affiliate'
#    And form field password = '2000'
#    When method post
#    * print responseHeaders



Feature: Login Basico Outline

  Background:
    * url 'https://0a4600cd03f53c898206f13500b400fa.web-security-academy.net'
    * configure headers = { Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' }
    * configure connectTimeout = 30000
    * configure readTimeout = 30000
    * configure followRedirects = true

  Scenario Outline: Login usando x-www-form-urlencoded
    * url 'https://0a8100a403fe655a81aa077c00ca00ec.web-security-academy.net'
    * configure headers = { Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' }
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

    * header Content-Type = 'application/x-www-form-urlencoded'

    And form field username = '<username>'
    And form field password = '<password>'
    Given path '/login'
    When method post
    Then status 200
    * print responseHeaders

    Examples:
      | username  | password |
      | affiliate | 2000     |
      | argentina | 1234   |




