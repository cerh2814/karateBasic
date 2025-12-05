Feature: simple login

  Background: base config
    Given url 'https://0a4600cd03f53c898206f13500b400fa.web-security-academy.net/'
    * header Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    * header User-Agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Karate'
    * configure connectTimeout = 60000
    * configure readTimeout = 60000
    * configure followRedirects = true

  Scenario Outline: simple login (expect 200)
    Given path '/login'
    When method get
    Then status 200

    # 2) extract CSRF token if the form includes one (adjust regex/name según el HTML real)
#    * def csrfMatch = response.match(/name="csrf" value="([^"]+)"/)
#    * def csrf = csrfMatch.length > 0 ? csrfMatch[0][1] : null

    # 3) send form as application/x-www-form-urlencoded (Karate sends cookies automatically)
    * header Content-Type = 'application/x-www-form-urlencoded'
    * header Referer = url + '/login'
    * header Origin = url
    * form field username = '<username>'
    * form field password = '<password>'
    * if (csrf != null) form field csrf = csrf
    Given path '/login'
    When method post
    Then status 200

    Examples:
      | username  | password |
      | root      | 000000   |
      | argentina | nicole   |
