Feature: Comprobar endpoint de login y crear artículo

  Background: Configuración base
    Given url 'https://conduit-api.bondaracademy.com/api'
    * header Accept = 'application/json'
    * configure connectTimeout = 8000
    * configure readTimeout = 8000

  Scenario Outline: Login y crear artículo (login espera 200, crear espera 201)
    * def loginPayload = { user: { email: 'uno@yopmail.com', password: '123QWer11' } }
    Given path 'users/login'
    And request loginPayload
    When method post
    Then status 200
    * def authToken = response.user.token
    * print 'Auth Token:', authToken
    * header Authorization = 'Token ' + authToken
    Given path 'articles'
    And request { article: { title: '<title>', description: '<decription>', body: '<body>', tagList: ['<taglist>'] } }
    When method post
    Then status 201
    * print 'Article Created:', response.article.title
    * match response.article.title == '<title>'
    * match response.article.description == '<decription>'
    * match response.article.body == '<body>'
    * match response.article.tagList == ['<taglist>']

    Examples:
      | title   | decription | body  | taglist     |
      | devxxq1 | test120q1  | one1q | ta1goneq    |
      | devyyq1 | xvffdh1dq  | ndn1q | ndn1tagqcls |


  Scenario Outline: listar las etiquetas
    Given path 'tags'
    When method get
    Then status 200
    * print 'Tags List:', response.tags
    * match response.tags contains '<tagname>'
    Examples:
      | tagname |
      | Test    |
      | Git     |


#    Scenario Outline: delete article
#    * def articleSlug = response.article.slug
#    Given path 'articles/dev13-38043', articleSlug
#    When method delete
#    Then status 204
#      Examples:





