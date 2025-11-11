Feature: Prueba de registro de usuario con captcha invalido

  Background:

    * url 'https://api.test.prestamype.com/v1/public/identity'

  Scenario: Verificar respuesta de token ReCaptcha invalido
    Given path '/account?captcha_token=0cAFcWeA7yDjbLaqa4Lg0aL2GGT14Ae7TxJlwaf-2rRr3YoYf16VSQ7UdFOzr3RMgzEOMm-MMrIccaHOxyzFNTxOe5gk_3HshvqAgS7u_GvlYkv4fcFurfrJNHPlHKKhFDR10w90BJo5XSVYPYScdcmK-A7ndZfaI3mB_gdIobF1X8IMEXVabMvtgkSm3wBdvC-Nvakv-QOFDGbKy-HN6cp0vzgM2-lT2Z_sDLpxnH7ql5WSTGb_S_tOTJWd_MFKQWmx0uNcsAtL6zySfZlDK7IB8N3upq2QBI7sKev8_lhwU2_NMq0P2r6tBnmJm51RpH_psFcVop0wg4B-wW_kkLDEo6pfD1Tmj61omqAc-mzodGzpbvysW_ickYo5Bh32cACZBvzghMM9opHIyQsM0SKw1g2S63oPmUbeboWGLwEjTRewwkosHYeVFGBAqv-F5cp6HnMDXkduzM8TN3YRZxi_OqdWbG4-D6ebqX0ZzukBLeVtF39q-Y7PN3BF3e-NpIdyAozGA1YqcrkvPPbzwO31Y89d8WA-CuK2CO9SIy4iHnEXsPqerDK0uFq8u_Q5Tdv8C9hZTOeat7v3IOlp5ANyj9rCkV8jGhpL28eDByB29aFa-zxq-SG0dK3Pdb8B08r5Gt5SGnUicqMlX2txVTYV9Y9U-DXu0cJZwd0IicOi1Mu_Ez4gkEEFmXZjhR4GZ9nD1YbeQLAjx8H2-RnqbLD-v4yglS74gqutWB4PHV34s9VjUtFnrpcYodlyhV0QT2SkAVVExVZaxR8O1cE_rNF1rHXA_PpaR7dKGmDBDwFZzL2L5JT-F3Knw'
    And request
"""
{
  "email":"dev09@yopmail.com",
  "password":"1111@eeeM",
  "document_type":"dni",
  "document":"11111111",
  "phone":"111111111111",
  "terms_and_conditions_v3_value":"accept"
}
"""
    When method POST
    Then status 404
    And match response.message == null


  Scenario Outline: Verificar respuesta de token ReCaptcha invalido
    Given path '/account?captcha_token=<captcha_token>'
    And request
    """
    {
      "email":"<email>",
      "password":"<password>",
      "document_type":"dni",
      "document":"<document>",
      "phone":"<phone>",
      "terms_and_conditions_v3_value":"accept"
    }
    """
    When method POST
    Then status 404
    And match response.message == null

    Examples:
      | captcha_token | email             | password  | document | phone        |
      | token-valor-1 | dev09@yopmail.com | 1111@eeeM | 11111111 | 111111111111 |
      | token-valor-2 | dev09@yopmail.com | 1111@eeeM | 11111111 | 111111111111 |
      | token-valor-2 | dev09@yopmail.com | 1111@eeeM | 12111111  | 111111111111 |

  Scenario: Verificar respuesta documentos invalidos
    Given path '/account?captcha_token=0cAFcWeA7yDjbLaqa4Lg0aL2GGT14Ae7TxJlwaf-2rRr3YoYf16VSQ7UdFOzr3RMgzEOMm-MMrIccaHOxyzFNTxOe5gk_3HshvqAgS7u_GvlYkv4fcFurfrJNHPlHKKhFDR10w90BJo5XSVYPYScdcmK-A7ndZfaI3mB_gdIobF1X8IMEXVabMvtgkSm3wBdvC-Nvakv-QOFDGbKy-HN6cp0vzgM2-lT2Z_sDLpxnH7ql5WSTGb_S_tOTJWd_MFKQWmx0uNcsAtL6zySfZlDK7IB8N3upq2QBI7sKev8_lhwU2_NMq0P2r6tBnmJm51RpH_psFcVop0wg4B-wW_kkLDEo6pfD1Tmj61omqAc-mzodGzpbvysW_ickYo5Bh32cACZBvzghMM9opHIyQsM0SKw1g2S63oPmUbeboWGLwEjTRewwkosHYeVFGBAqv-F5cp6HnMDXkduzM8TN3YRZxi_OqdWbG4-D6ebqX0ZzukBLeVtF39q-Y7PN3BF3e-NpIdyAozGA1YqcrkvPPbzwO31Y89d8WA-CuK2CO9SIy4iHnEXsPqerDK0uFq8u_Q5Tdv8C9hZTOeat7v3IOlp5ANyj9rCkV8jGhpL28eDByB29aFa-zxq-SG0dK3Pdb8B08r5Gt5SGnUicqMlX2txVTYV9Y9U-DXu0cJZwd0IicOi1Mu_Ez4gkEEFmXZjhR4GZ9nD1YbeQLAjx8H2-RnqbLD-v4yglS74gqutWB4PHV34s9VjUtFnrpcYodlyhV0QT2SkAVVExVZaxR8O1cE_rNF1rHXA_PpaR7dKGmDBDwFZzL2L5JT-F3Knw'
    And request
"""
{
  "email":"dev09@yopmail.com",
  "password":"1111@eeeM",
  "document_type":"dni",
  "document":"ab111111",
  "phone":"111111111111",
  "terms_and_conditions_v3_value":"accept"
}
"""
    When method POST
    Then status 404
    And match response.message == null


  Scenario Outline: Verificar respuesta de token ReCaptcha invalido
    Given path '/account?captcha_token=<captcha_token>'
    And request
    """
    {
      "email":"<email>",
      "password":"<password>",
      "document_type":"dni",
      "document":"<document>",
      "phone":"<phone>",
      "terms_and_conditions_v3_value":"accept"
    }
    """
    When method POST
    Then status 404
    And match response.message == null

    Examples:
      | captcha_token | email             | password  | document | phone        |
      | token-valor-1 | dev09@yopmail.com | 1111@eeeM | ab111111 | 111111111111 |
