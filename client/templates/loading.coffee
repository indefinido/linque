spinner = '<div class="sk-spinner sk-spinner-three-bounce"><div class="sk-bounce sk-bounce1"></div><div class="sk-bounce sk-bounce2"></div><div class="sk-bounce sk-bounce3"></div></div>'

Template.registerHelper 'loaded', ->
  Session.get('loaded')


Session.set 'loaded', false

Template.loading.rendered = ->
  return if Session.get 'loaded'
  
  @loading = window.pleaseWait
    logo: '/images/logo.svg'
    backgroundColor: '#0074b3'
    loadingHtml: spinner

Template.loading.destroyed = ->
  @loading.finish() if @loading

Template.main.rendered = ->
  Session.set 'loaded', true

Template.loginButtons.rendered = ->
  console.log(this)
  $('#login-sign-in-link').text "Efetuar Login"
  $('#login-sign-in-link .sign-in-text-facebook').text "Entrar com Facebook"
  $('#login-sign-in-link .sign-in-text-google').text "Entrar com Google"
