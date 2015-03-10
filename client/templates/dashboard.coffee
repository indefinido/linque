Meteor.subscribe "user"
Meteor.subscribe "skills"
Meteor.subscribe "levels"

## Helpers

Template.dashboard.helpers

  requiredExperience: ->
    level = Levels.findOne( _id: Meteor.user().level )
    if level then level.experience else false

  earnedExperience: ->
    Session.get 'earnedExperience'

  percentage: ->
    user  = Meteor.user()
    level = Levels.findOne( _id: user.level )

    if level and level.experience
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
Template.dashboard.events

  # FIXME event being fired twice in touch devices
  'click .skill .button.active': (event) ->
    Meteor.call "useSkill", @_id
    event.stopPropagation()
    false


  
Template.dashboard.rendered = ->
  Meteor.setTimeout ->
    progress = document.querySelector '.progress paper-progress::shadow #progressContainer, .progress paper-progress #progressContainer'
    progress.title = "Pontos de Hábito (PH)"
  , 5000


Meteor.startup ->

  Session.set 'earnedExperience', null

  experienceTimeout = null
  earnedPlaceholder = null

  clearExperience = _.debounce ->
    earnedPlaceholder.removeClass 'visible'
    Session.set 'earnedExperience', null
  , 2000


  Tracker.autorun ->
    return unless Session.get 'earnedExperience'
    
    earnedPlaceholder ||= $ '#earned-experience'
    earnedPlaceholder.removeClass 'visible'
    earnedPlaceholder.addClass 'visible'
    
    clearExperience()


  $('body').attr 'fullbleed', true
  $('body').attr 'layout', true
  $('body').attr 'vertical', true
  
  
  
