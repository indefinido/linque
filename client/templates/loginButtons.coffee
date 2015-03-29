 
Template._loginButtonsLoggedOutDropdown.rendered = ->
  $('.login-close-text').text "Fechar"
  $('.sign-in-text-facebook', this.firstNode).text "Entrar com Facebook"
  $('.sign-in-text-google'  , this.firstNode).text "Entrar com Google"

Template._loginButtonsLoggedInDropdown.rendered = ->
  $('#login-buttons-logout').text "Sair"
  $('.login-close-text').text "Fechar"
  

Template.loginButtons.rendered = ->
  $('#login-sign-in-link'   , this.firstNode).text "Efetuar Login"


