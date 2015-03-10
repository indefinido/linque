Meteor.startup ->
  Meteor.call 'getEnvironment', (error, environment) ->
    Meteor.env = environment
    GAnalytics.pageview() unless environment == 'development'


  Tracker.autorun ->
    if Meteor.userId() and Meteor.env != 'development'
      ga 'set', '&uid', Meteor.userId()
      GAnalytics.event "User", "Session Restored"
