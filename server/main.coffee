Meteor.startup ->


  Accounts.onCreateUser (options, user) ->

    user.experience      = 0
    user.levelExperience = 0
    user.level           = 1
    
    # initialize skills on User
    user.skills = {}
    Skills.find().forEach (skill) ->
      # get required level of first skill
      requiredLevel = skill.levels[0].requiredLevel
      
      user.skills[skill._id] =
        # gives all skills that start on level 1
        level   : (if requiredLevel == 1 then 1 else null)
        cooldown: null

    # We still want the default hook's 'profile' behavior.
    if options.profile
      user.profile = options.profile

    user