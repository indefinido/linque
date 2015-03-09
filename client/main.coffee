Meteor.startup ->
  Meteor.call 'getEnvironment', (error, environment) ->
    Meteor.env = environment

    GAnalytics.pageview() unless environment == 'development'
