Feature: Consulta de producto en FakeStoreAPI

  Background: define url y timeouts
    Given url 'https://fakestoreapi.com'
    * header Accept = 'application/json'
    * configure connectTimeout = 5000
    * configure readTimeout = 5000

  Scenario: Obtener producto por id
    Given path 'products', '2'
    When method get
    * print 'Status: ' + responseStatus
    * print 'Response: ' + response
    Then status 200
    And match response.id == 2
    And match response.title contains 'Mens Casual'
    # Comparación con tolerancia para evitar errores por decimales
    * def diff = response.price - 22.3
    * assert diff >= -0.01 && diff <= 0.01
    And match response.category == 'men\'s clothing'
    # Validación parcial del rating y un chequeo mínimo del rate
    And match response.rating contains { rate: '#number', count: '#number' }
    And assert response.rating.rate >= 4.0
    And match response.image contains 'https://fakestoreapi.com/img/'

  Scenario: Obtener producto por id
    Given path 'products', '2'
    When method get
    * print 'Status: ' + responseStatus
    * print 'Response: ' + response
    Then status 200
    And match response.id == 2
    And match response.title contains 'Mens Casual'
    # Comparación con tolerancia para evitar errores por decimales
    * def diff = response.price - 23.0
    * assert diff >= -0.01 && diff <= 0.01
    And match response.category == 'men\'s clothing'
    # Validación parcial del rating y un chequeo mínimo del rate
    And match response.rating contains { rate: '#number', count: '#number' }
    And assert response.rating.rate >= 4.0
    And match response.image contains 'https://fakestoreapi.com/img/'

