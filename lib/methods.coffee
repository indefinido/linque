Meteor.methods
  useSkill: (id) ->
    skill = Skills.findOne { _id: id }
    user  = Meteor.user()

    # get current user skill level
    skillLevel = null
    for level in skill.levels
      if level.level == user.skills[skill._id].level
        skillLevel = level

    return false unless skillLevel


    # TODO check cooldown here



    # experience given by the use of the current skill
    # TODO update calculation
    earnedExperience = skillLevel.experience


    # Record skill usage
    Activities.insert
      userId: user._id
      createdAt: new Date
      type: 'skillUse'
      data:
        skill     : skill._id
        name      : skill.name
        qualifier : skillLevel.qualifier
        level     : skillLevel.level
        experience: earnedExperience


    currentLevel = Levels.findOne { _id: user.level }

    # TODO move to appropriate place
    user.levelExperience ||= 0

    # find next level
    nextLevel = Levels.findOne _id: user.level + 1

    # whether or not the user has leveled up based on his current level experience
    leveledUp = nextLevel and user.levelExperience + earnedExperience >= currentLevel.experience

    if leveledUp
      # reset experience and continue summing
      levelExperience = user.levelExperience + earnedExperience - currentLevel.experience
    else
      # just sum the earned experience
      levelExperience = user.levelExperience + earnedExperience


    # amount of levels to increment
    levelUp = if leveledUp then 1 else 0


    # update user experience
    Meteor.users.update { _id: user._id },
      $inc:
        experience: earnedExperience
        level     : levelUp
      $set:
        levelExperience: levelExperience


    # update user variable
    user = Meteor.user()


    # Report earned experience to client
    if Meteor.isClient
      Session.set 'earnedExperience', earnedExperience

    # Report earned experience to client
    # TODO move to a analytics special place
    if Meteor.isClient && Meteor.env != 'development'
      GAnalytics.event 'Skill', 'Use', "id: #{skill._id} - level: #{skillLevel.level}"


    if leveledUp

      # Record level up
      Activities.insert
        userId: user._id
        createdAt: new Date
        type: 'levelUp'
        data:
          level: user.level


      # Check level up for skills
      skillsChanged = false
      Skills.find().forEach (skill) ->
        userSkill = user.skills[skill._id]
        for skillLevel in skill.levels
          if user.level is skillLevel.requiredLevel
            userSkill.level = skillLevel.level
            skillsChanged   = true

            # Record skill level up
            Activities.insert
              userId: user._id
              createdAt: new Date
              type: 'skillLevelUp'
              data:
                skill    : skill._id
                name     : skill.name
                qualifier: skillLevel.qualifier
                level    : skillLevel.level

      if skillsChanged
        Meteor.users.update { _id: user._id }, $set:
          skills: user.skills


      # user = Meteor.user()
