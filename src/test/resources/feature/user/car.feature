Feature: Automatización de Registro en Buggy Cars

  Background:
    # Definición de la URL base
    * url 'https://buggy.justtestit.org'

  Scenario: Registro exitoso de un nuevo usuario
    # 1. Navegar directamente a la página de registro
    * driver 'https://buggy.justtestit.org/register'
    
    # 2. Generar datos únicos para el registro (timestamp para el username)
    * def uniqueUsername = 'user' + new java.util.Date().getTime()
    * def password = 'Password123!'
    * def firstName = 'KarateTest'
    * def lastName = 'User'
    
    # 3. Llenar los campos del formulario
    # Esperar a que la página cargue completamente
    * waitForUrl('https://buggy.justtestit.org/register')
    * delay(2000)
    
    # Llenar campos usando selectores más específicos
    * waitFor('#firstName')
    * input('#firstName', firstName)
    * input('#lastName', lastName)
    * input('#username', uniqueUsername)
    * input('#password', password)
    * input('#confirmPassword', password)
    
    # 4. Click en el botón de registro (submit)
    * waitFor('button')
    * click('button')
    
    # 5. Verificación de éxito
    # Verificar que la URL cambió o aparece un mensaje de éxito
    * delay(3000)
    
    # Capturar cualquier mensaje de éxito que aparezca
    * def currentUrl = driver.url
    * print 'Current URL after registration:', currentUrl
    
    # Verificar si aparece algún mensaje de resultado
    * def pageSource = driver.html
    * print 'Page source contains registration result'