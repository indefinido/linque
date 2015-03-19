# TODO lock rule if it is on maximun level
Template.rule.helpers

  id      : -> @_id

  level   : -> Meteor.user().rules[@_id].level


  # name of current level of user rule
  currentLevel : ->
    ruleId      = @_id
    
    currentLevel = null
    @currentLevel.unlocked = false if @currentLevel
  
    # get current level
    for level in @levels
      if level.level == Meteor.user().rules[ruleId].level
        currentLevel = level
  
    currentLevel

  # rule can level up?
  levelable: -> @levelable()
