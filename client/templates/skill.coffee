
Template.skill.helpers

  id      : -> @_id
  passive : -> not @active()
  level   : -> Meteor.user().skills[@_id].level 

  
  # name of current level of user skill
  # TODO improve
  name    : -> 
    skillId = @_id
    name = null
    _.each @levels, (level) ->
      if level.level == (Meteor.user().skills[skillId].level || 1)
        name = level.name
    name

      
  # name of current level of user skill      
  # TODO improve
  summary : -> 
    skillId = @_id
    currentLevel = null
    
    # get current level
    _.each @levels, (level) ->
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
    attrs.raised   = true     if @active()
    attrs.disabled = true unless @active() and unlocked
    attrs
  
  # button classes
  classes : -> 
    classes = []
    classes.push "#{@activity}"
    classes.join()

