Meteor.subscribe "user"
Meteor.subscribe "skills"
Meteor.subscribe "levels"




## Helpers


Template.user.helpers
    
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

  skillsLeft: ->
    skills = Skills.find({}).fetch()
    skills.splice 0, skills.length / 2
    
  skillsRight: ->
    skills = Skills.find({}).fetch()
    skills.splice skills.length / 2 , skills.length / 2




## Events


# TODO move to skills template (and skill.coffe file)?
Template.user.events

  # FIXME event being fired twice in touch devices
  'click .skill .button.active, touchstart .skill .button.active': ->
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
    
    
  if Meteor.isClient
    $('body').attr 'fullbleed', true
    $('body').attr 'layout', true
    $('body').attr 'vertical', true