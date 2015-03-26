Meteor.startup ->
  Meteor.call 'getEnvironment', (error, environment) ->
     Meteor.env = environment
     integrations() unless computation.stopped

  integrations = ->
    return unless user        = Meteor.user()
    return unless environment = Meteor.env
    
    unless environment == 'development'
      ga 'set', '&uid', user._id
      GAnalytics.event "User", "Session Restored"
      GAnalytics.pageview()
    
    olark 'api.visitor.getDetails', ->
      details = arguments[0]
      
      unless details.fullName == user.profile.name
        olark 'api.visitor.updateFullName',
        fullName: user.profile.name
      
      emailAddress = user.services.facebook?.email || user.services.google?.email
      unless details.emailAddress == emailAddress 
        olark 'api.visitor.updateEmailAddress',
        emailAddress: emailAddress
        
    computation.stop();

  computation  = Tracker.autorun integrations
      
