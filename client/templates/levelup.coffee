@SkillLevelUps = new Mongo.Collection "skillLevelUps"
@SkillLevelUps.allow update: -> true

Meteor.subscribe "skillLevelUps"


Template.levelup.helpers

  level: ->
    Meteor.user().level


Template.skillLevelUps.helpers

  skillLevelUps: ->
    skill = SkillLevelUps.find {}
    
    
Template.skillLevelUp.helpers
  skill: -> 
    skill = Skills.findOne _id: @data.skill
    currentLevel = null
    
    # get current level
    for level in skill.levels
      currentLevel = level if level.level is @data.level 
      
    currentLevel.skill = { name: skill.name }
    currentLevel
  
  
# Template.newSkillLevel.helpers
  
    
  
skiller = do ->
  i: 0

  next: ->
  
    skill = SkillLevelUps.findOne {}, skip: skiller.i
    return unless skill
    
    skillDialog = $ "#skill-levelup-dialog-#{skill._id}"
  
    skillDialog.get(0).open()
    skillDialog.one 'core-overlay-close-completed', ->
      skillDialog.remove() # TODO is it safe?
      skiller.i++
      skiller.next()



Meteor.startup ->

  Session.set 'level', null

  # Tracks level changes to open level up dialog
  Tracker.autorun ->
    return unless Meteor.user()
    
    previousLevel = Session.get 'level'
    nextLevel     = Meteor.user().level
    
    return unless nextLevel
    
        
    if previousLevel? and nextLevel > previousLevel

      # open level up dialog
      dialog = $('#levelup-dialog')
      dialog.get(0).open()
      dialog.one 'core-overlay-close-completed', skiller.next
        
      

    Session.set 'level', nextLevel
    
    
