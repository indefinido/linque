Meteor.startup ->
  Meteor.call 'getEnvironment', (error, environment) ->
    Meteor.env = environment
    GAnalytics.pageview() unless environment == 'development'

     
  Tracker.autorun ->
    
    if Meteor.user()
      user = Meteor.user()
	
	    unless Meteor.env == 'development'
        ga 'set', '&uid', user._id
        GAnalytics.event "User", "Session Restored"

      olark 'api.visitor.getDetails', ->
        details = arguments[0]

        unless details.fullName == user.profile.name
          olark 'api.visitor.updateFullName',
	          fullName: user.profile.name

        emailAddress = user.services.facebook?.email || user.services.google?.email
        unless details.emailAddress == emailAddress 
          olark 'api.visitor.updateEmailAddress',
		        emailAddress: emailAddress
