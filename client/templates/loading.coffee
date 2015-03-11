spinner = '<div class="sk-spinner sk-spinner-three-bounce"><div class="sk-bounce sk-bounce1"></div><div class="sk-bounce sk-bounce2"></div><div class="sk-bounce sk-bounce3"></div></div>'

Template.registerHelper 'loaded', ->
  Session.get('loaded')


Session.set 'loaded', false

Template.loading.rendered = ->
  return if Session.get 'loaded'
  
  @loading = window.pleaseWait
    logo: '/images/logo.svg'
    backgroundColor: '#2689be'
    loadingHtml: spinner

Template.loading.destroyed = ->
  @loading.finish() if @loading

Template.main.rendered = ->
  Session.set 'loaded', true
