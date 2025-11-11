Feature: Comprobar endpoint de login y crear artículo

  Background: Configuración base
    Given url 'https://conduit-api.bondaracademy.com/api'
    * header Accept = 'application/json'
    * configure connectTimeout = 8000
    * configure readTimeout = 8000

  Scenario: Login y crear artículo (login espera 200, crear espera 201)
    * def loginPayload = { user: { email: 'uno@yopmail.com', password: '123QWer11' } }
    Given path 'users/login'
    And request loginPayload
    When method post
    Then status 200
    * def authToken = response.user.token
    * print 'Auth Token:', authToken
    * header Authorization = 'Token ' + authToken
    Given path 'articles'
    And request { article: { title: 'dev13', description: 'test', body: 'test test', tagList: ['testdd'] } }
    When method post
    Then status 201
    * print 'Article Created:', response.article.title
    * match response.article.title == 'dev13'
    * match response.article.description == 'test'
    * match response.article.body == 'test test'
    * match response.article.tagList == ['testdd']



