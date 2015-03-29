{animator} = share

loader =
  
  readiness:
    rendering: 
      main     : $.Deferred()
      character: $.Deferred()
    polymer: $.Deferred()
  
  initialize: ->
    @unloaded()
    $.when(_.values(loader.readiness)...).then @loaded

    # Callbacks
    Template.registerHelper 'loaded', @helper
    Template.loading.onRendered @onRendered
    Template.loading.onDestroyed @onDestroyed

    Template.signIn.onRendered    -> loader.readiness.rendering.main.resolve()
    Template.pathway.onRendered   -> loader.readiness.rendering.main.resolve()
    Template.character.onRendered -> loader.readiness.rendering.character.resolve()
    
    document.addEventListener 'polymer-ready', -> loader.readiness.polymer.resolve()

  # Actions
  unloaded: -> Session.set 'loaded', false
  loaded  : -> Session.set 'loaded', true
  helper  : -> Session.get 'loaded'

  finished: ->
    @removeEventListener 'webkitAnimationEnd', loader.finished

  # State
  options:
    loadingHtml: '<div class="sk-spinner sk-spinner-three-bounce"><div class="sk-bounce sk-bounce1"></div><div class="sk-bounce sk-bounce2"></div><div class="sk-bounce sk-bounce3"></div></div>'
    logo: '/images/logo.svg'
    backgroundColor: '#0074b3'
  
  onRendered: ->
    return if Session.get 'loaded'
     
    @loading = window.pleaseWait loader.options
    
    screen = $('.pg-loading-screen').get(0)
    screen.addEventListener 'DOMNodeRemoved', loader.finished
    
  onDestroyed: _.debounce ->
    @loading.finish() if @loading
    animator.presentTo '#user'
  , 1000

loader.initialize()
