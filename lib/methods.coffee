Meteor.methods
  
  useSkill: (id) ->
    skill = Skills.findOne { _id: id }
    user  = Meteor.user()
    
    # get current user skill level
    skillLevel = null
    _.each skill.levels, (level) ->
      if level.level == user.skills[skill._id].level
        skillLevel = level
    
    # experience given by the use of the current skill
    # TODO update calculation
    earnedExperience = skillLevel.experience
    
    
    valid = true
    
    # TODO learn how to tell that something is wrong
    valid = false unless skillLevel
    
    
    if valid
      
      # Record skill usage
      Activities.insert 
        userId: user._id
        createdAt: new Date
        type: 'skillUse'
        data: 
          skillId: skill._id
          name : skillLevel.name
          level: skillLevel.level
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
      
      
      # Report earned experience to client
      if Meteor.isClient
        Session.set 'earnedExperience', earnedExperience
      
      
      if leveledUp
        
        # Record level up
        Activities.insert 
          userId: user._id
          createdAt: new Date
          type: 'levelUp'
          data:
            level: Meteor.user().level
        
        # Notify the client about the new level
        if Meteor.isClient          
          Session.set 'level', Meteor.user().level   
          
        
        # TODO check for skill level up here
        
