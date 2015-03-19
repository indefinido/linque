Meteor.startup ->

  Accounts.onCreateUser (options, user) ->

    # default values
    user.position      = 0
    user.rules         = {}
    user.profile     ||= {}
    user.services    ||= {}

    # initialize rules
    # gives all rules at level 1
    Rules.find().forEach (rule) -> user.rules[rule._id] = level: 1

    # Set default profile picture
    if options.profile

      if user.services.facebook?
        # facebook profile picture
        options.profile.picture = "http://graph.facebook.com/#{user.services.facebook.id}/picture/?type=large"
        
      if user.services.google?
        options.profile.picture = user.services.google.picture

      user.profile = options.profile
      
    user.profile.picture = 'http://placehold.it/250/0074B3/FFFFFF' unless user.profile.picture?

    # return user document
    user

Meteor.methods 
  getEnvironment: -> if process.env.ROOT_URL == "http://localhost:3000/" then "development" else "staging"

