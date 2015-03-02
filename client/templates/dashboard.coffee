Meteor.subscribe "user"
Meteor.subscribe "skills"
Meteor.subscribe "levels"
Meteor.subscribe "activities"




## Helpers


Template.user.helpers
  experience: ->
    Meteor.user().levelExperience || 0
    
  requiredExperience: ->
    Levels.findOne( _id: Meteor.user().level ).experience || ""
    
  earnedExperience: ->
    Session.get 'earnedExperience'
    
  percentage: ->
    user  = Meteor.user()
    level = Levels.findOne( _id: Meteor.user().level )
    if level.experience
      user.levelExperience / level.experience * 100
    else
      100

  level: ->
    level = Meteor.user().level
    level


Template.actions.helpers
  skills: ->
    Skills.find {}




## Events


# TODO move to skills template (and skill.coffe file)?
Template.user.events
  'click .skill .button.active': ->
    Meteor.call "useSkill", @_id






Meteor.startup ->
  
  Session.set 'level', null
  Session.set 'earnedExperience', null
  

  # Tracks level changes to open level up dialog
  Tracker.autorun ->
    level = Session.get 'level'
    # open level up dialog
    $('#levelup-dialog').get(0).open() if level
    
  
  
    
  experienceTimeout = null
  
  # Show earned experience
  # TODO refactor!
  Tracker.autorun ->
    Meteor.clearTimeout experienceTimeout
    
    experience = Session.get 'earnedExperience'
    return unless experience
    
    earned = $ '#earned-experience'
    earned.hide()
    earned.fadeIn 'fast'
    experienceTimeout = Meteor.setTimeout -> 
      earned.fadeOut 'slow', -> 
        Session.set 'earnedExperience', null
    , 2000
    