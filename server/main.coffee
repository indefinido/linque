Meteor.startup ->

  Accounts.onCreateUser (options, user) ->

    # default values
    user.experience      = 0
    user.levelExperience = 0
    user.level           = 1

    # initialize skills
    user.skills = {}
    Skills.find().forEach (skill) ->
      # get required level of first skill
      requiredLevel = skill.levels[0].requiredLevel

      user.skills[skill._id] =
        # gives all skills that start on level 1
        level   : (if requiredLevel == 1 then 1 else null)


    if options.profile

      if user.services.facebook?
        # facebook profile picture
        options.profile.picture = "http://graph.facebook.com/#{user.services.facebook.id}/picture/?type=large"
        
      if user.services.google?
        options.profile.picture = user.services.google.picture

      user.profile = options.profile;

    user

Meteor.methods 
  getEnvironment: -> if process.env.ROOT_URL == "http://localhost:3000/" then "development" else "staging"

