
Template.skill.helpers

  id      : -> @_id
  passive : -> not @active()
  level   : -> Meteor.user().skills[@_id].level 

  
  # name of current level of user skill
  # TODO improve
  qualifier: ->
    skillId   = @_id
    qualifier = null
    for level in @levels
      if level.level == (Meteor.user().skills[skillId].level || 1)
        qualifier = level.qualifier
    qualifier

      
  # name of current level of user skill      
  # TODO improve
  summary : -> 
    skillId = @_id
    currentLevel = null
    
    # get current level
    for level in @levels
      if level.level == (Meteor.user().skills[skillId].level || 1)
        currentLevel = level
        
    summary = currentLevel.summary
    
    # Inform when level is unlockd, if locked
    # TODO move to appropriate place
    if Meteor.user().skills[skillId].level == null
      summary = "(Libera no level #{currentLevel.requiredLevel}) #{summary}"
      
    summary

  
  # current user acquired skill?
  unlocked:  -> Meteor.user().skills[@_id].level?
  
  # skill can level up?
  levelable: -> @levelable()
  
  # button attributes
  attrs: ->
    # unlocked if user has the skill level defined
    unlocked = Meteor.user().skills[@_id].level?

    attrs = {}
    attrs.noink = true unless @active() and unlocked
    attrs
  
  # button classes
  classes : -> 
    # unlocked if user has the skill level defined  
    unlocked = Meteor.user().skills[@_id].level?
    
    classes = []
    classes.push "#{@activity}"
    classes.push "locked" unless unlocked
    classes.join " "

