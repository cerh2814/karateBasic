Feature: visit login page

  Background:
    * url 'https://conduit.bondaracademy.com/'

  Scenario: iniciar sesión en la aplicación
    * driver 'https://conduit.bondaracademy.com/'
    * waitForUrl('https://conduit.bondaracademy.com/')
    Given I am on the login page
    * xpath('//a[@href="#/login"]').click()
    * xpath('//input[@placeholder="Email"]').sendKeys('TU_EMAIL')
    * xpath('//input[@placeholder="Password"]').sendKeys('TU_PASSWORD')
    * xpath('//button[contains(.,"Sign in")]').click()
    * waitForUrl('https://conduit.bondaracademy.com/#/')
    Then I should see the home page
    * xpath('//a[@href="#/editor"]').exists()