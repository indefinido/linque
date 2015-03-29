{animator} = share

loader =
  
  readiness:
    rendering: $.Deferred()
    polymer  : $.Deferred()
  
  initialize: ->
    @unloaded()
    
    $.when(_.values(loader.readiness)...).then @loaded

    # Callbacks
    Template.registerHelper 'loaded', @helper
    Template.loading.onRendered @onRendered
    Template.loading.onDestroyed @onDestroyed

    Template.signIn.onRendered  -> loader.readiness.rendering.resolve()
    Template.pathway.onRendered -> loader.readiness.rendering.resolve()
    
    document.addEventListener 'polymer-ready', -> loader.readiness.polymer.resolve()

  # Actions
  unloaded: -> Session.set 'loaded', false
  loaded:   -> Session.set 'loaded', true
  helper  : -> Session.get 'loaded'

  finished: _.debounce ->
    animator.presentTo '.user'
    @removeEventListener 'webkitAnimationEnd', loader.finished
  , 1000

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
    
  onDestroyed: ->
    @loading.finish() if @loading

loader.initialize()
