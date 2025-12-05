#Feature: lista tags
#
#  #caracteristicas comuns que se aplicaran a los escenarios
#  Background:
#    * url 'https://conduit-api.bondaracademy.com/'
#    * configure headers = { Accept: 'application/json, text/plain, */*' }
#    * configure connectTimeout = 30000
#    * configure readTimeout = 30000
#
#  Scenario Outline: tags list
#
#    Given path '<endpoint>'
#    When method <method>
#    Then status <status>
#    * print responseHeaders
#
#    Examples:
#      | endpoint     | method | status |
#      | api/articles | get      | 200    |
#
#    Scenario Outline:  login conduit invalid
#      Given path '<endpoint>'
#      And request { "user": { "email": '<email>', "password": '<password>', "username": '<username>' } }
#      Then method <method>
#      And status <status>
#      * print responseHeaders
#      * match response.errors.email[0] == 'is invalid'
#      * match response.errors.password[0] == 'is too short (minimum is 8 characters)'
#      Examples:
#        | endpoint   | email | password | username | method | status |
#        | api/users/ | www   | www      | wwww     | post   | 422      |
#
#  Scenario Outline:  login conduit valid
#    Given path '<endpoint>'
#    And request { "user": { "email": '<email>', "password": '<password>', "username": '<username>' } }
#    Then method <method>
#    And status <status>
#    * print responseHeaders
#    #* match response.errors.password[0] == 'is too short (minimum is 8 characters)'
#    Examples:
#      | endpoint   | email                   | password     | username   | method | status |
#      | api/users/ | xxeeaa13211@yopmail.com | www1223333aA | xxeeaa1113 | post   | 201    |
#
#
#  Scenario Outline:  login conduit valid
#    Given path '<endpoint>'
#    And request { "user": { "email": '<email>', "password": '<password>'} }
#    Then method <method>
#    And status <status>
#    * print responseHeaders
#    * match response.user.email == '<email>'
#    * match response.user.token != null
#    * def token = response.user.token
#    * print 'token =', token
#    * match response.user.username == 'xxaa1113'
#    Examples:
#      | endpoint        | email                 | password     | method | status |
#      | api/users/login | xxaa13211@yopmail.com | www1223333aA | post   | 200    |


Feature: Crear un nuevo artículo
  ##caracteristicas comunes que se aplicaran en los escenarios
  Background:
    * url 'https://conduit-api.bondaracademy.com'
    * def token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo0MTc5NX0sImlhdCI6MTc2NDg4NDM1MSwiZXhwIjoxNzcwMDY4MzUxfQ.JOeZoMi_fzq_w6igVk5ZNWHP5LHKX9R1jw6Cn1V9IXA'

  Scenario Outline: Publicar un artículo con datos válidos
    * def requestBody =
      """
      {
        "article": {
          "title": <title>,
          "description": <description>,
          "body": <body>
          "tagList": []
        }
      }
      """
    * header Authorization = 'Token ' + token
    * param token = token
    * path '<endpoint>'
    * request requestBody
    * method <method>
    * status <status>
#    * match response.article.title == response.article.title
#    * match response.article.description == response.article.description
#    * match response.article contains { slug: '#string', createdAt: '#string' }

    Examples:
      | title | description | body | endpoint                   | method | status |
      | aa    | aaa         | aa   | api/articles/test111-41795 | Put    | 200    |







