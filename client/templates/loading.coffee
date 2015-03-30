loader =
  
  readiness:
    character: $.Deferred()
    signIn   : $.Deferred()
    pathway  : $.Deferred()
    polymer  : $.Deferred()
  
  initialize: ->
    @unloaded()

    signedIn = Meteor.userId() 
    
    loadingReady = []
    loadingReady.push loader.readiness.character  if signedIn 
    loadingReady.push loader.readiness.pathway    if signedIn
    loadingReady.push loader.readiness.signIn
    loadingReady.push loader.readiness.polymer
    $.when(loadingReady...).then @loaded
        
    Tracker.autorun (computation) =>
      # every time a user signs in and the loading is done
      return unless Meteor.userId()
      return unless Session.get 'loaded'
      pathwayReady = []
      pathwayReady.push loader.readiness.character
      pathwayReady.push loader.readiness.pathway
      $.when(pathwayReady...).then @scroll


    # Callbacks
    Template.registerHelper 'loaded', @helper
    Template.loading.onRendered @onRendered
    Template.loading.onDestroyed @onDestroyed

    Template.signIn.onRendered    -> loader.readiness.signIn.resolve()
    Template.pathway.onRendered   -> loader.readiness.pathway.resolve()
    Template.character.onRendered -> loader.readiness.character.resolve()
    
    document.addEventListener 'polymer-ready', -> loader.readiness.polymer.resolve()

  # Actions
  unloaded: -> Session.set 'loaded', false
  loaded  : -> Session.set 'loaded', true
  helper  : -> Session.get 'loaded'
  scroll  : -> share.animator.presentTo '#user'

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
  , 1000

loader.initialize()
