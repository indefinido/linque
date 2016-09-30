Meteor.startup ->

  Accounts.onCreateUser (options, user) ->

    # default values
    user.position      = 1
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

    user.profile.picture = 'https://pbs.twimg.com/profile_images/1444393958/d_silhouette_gandalf_400x400.jpg' unless user.profile.picture?

    # return user document
    user

Meteor.methods
  getEnvironment: -> if process.env.ROOT_URL == "http://localhost:3000/" then "development" else "staging"


configurations =
  facebook:
    loginStyle: 'redirect'
  google:
    loginStyle: 'redirect'

for service, configuration of configurations
  console.log service, configuration
  ServiceConfiguration.configurations.upsert {service: service}, $set: configuration
