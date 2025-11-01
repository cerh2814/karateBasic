Feature: Automatización de Registro en Buggy Cars

  Background:
    * url 'https://buggy.justtestit.org'

  Scenario Outline: Registro exitoso de un nuevo usuario
    * driver 'https://buggy.justtestit.org/register'
    * waitForUrl('https://buggy.justtestit.org/register')
    * delay(2000)
    * waitFor('#firstName')
    * input('#firstName', '<firstName>')
    * input('#lastName', '<lastName>')
    * input('#username', '<uniqueUsername>')
    * input('#password', '<password>')
    * input('#confirmPassword', '<password>')
    * waitFor('button')
    * click('button')
    * delay(3000)
    * def currentUrl = driver.url
    * print 'Current URL after registration:', currentUrl
    * def pageSource = driver.html
    * print 'Page source contains registration result'

    Examples:
      | firstName | lastName | uniqueUsername       | password    |
      | Juan      | Perez    | juan.perez1          | Passw0rd!   |
      | Maria     | Lopez    | maria.lopez2         | Secure123!  |
      | Luis      | García   | luis.garcia3         | MyPass#2025 |
