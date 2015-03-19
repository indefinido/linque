# TODO rename skills to rule
Template.rule.helpers

  id      : -> @_id

  passive : -> not @active()

  level   : -> Meteor.user().skills[@_id].level || 1

  qualifier: ->
    skillId   = @_id
    qualifier = null

    for level in @levels
      if level.level == Meteor.user().skills[skillId].level
        qualifier = level.qualifier
    qualifier


  # name of current level of user skill
  currentLevel : ->
    skillId      = @_id
    
    currentLevel = null
    @currentLevel.unlocked = false if @currentLevel

    # get current level
    for level in @levels
      if level.level == Meteor.user().skills[skillId].level
        currentLevel = level

    currentLevel.unlocked = true

    @currentLevel = currentLevel


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
