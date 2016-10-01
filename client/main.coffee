Meteor.startup ->
  Meteor.call 'getEnvironment', (error, environment) ->
     Meteor.env = environment
     integrations() unless computation.stopped


  setTimeout ->
    Meteor.insecureUserLogin "demo-lucifer-#{Random.id()}", (a) ->
      alert 'something terrible wrong happened!' if a
  , 3000

  integrations = ->
    return unless user        = Meteor.user()
    return unless environment = Meteor.env

    unless environment == 'development'
      ga 'set', '&uid', user._id
      GAnalytics.event "User", "Session Restored"
      GAnalytics.pageview()

    
    computation.stop();

  computation  = Tracker.autorun integrations
