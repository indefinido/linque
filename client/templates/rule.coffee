
ruleLevel = (ruleId) ->
  Meteor.user().rules[ruleId].level


# TODO lock rule if it is on maximun level
Template.rule.helpers

  id      : -> @_id

  level   : -> ruleLevel @_id


  # name of current level of user rule
  currentLevel : ->
    ruleId      = @_id
    
    currentLevel = null
    @currentLevel.unlocked = false if @currentLevel
  
    # get current level
    for level in @levels
      if level.number == ruleLevel ruleId
        currentLevel = level
  
    currentLevel

  # rule can level up?
  levelable: -> @levelable()
