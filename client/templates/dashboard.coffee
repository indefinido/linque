Meteor.subscribe "user"
Meteor.subscribe "skills"
Meteor.subscribe "levels"

## Helpers

Template.dashboard.helpers

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
Template.dashboard.events

  # FIXME event being fired twice in touch devices
  'click .skill .button.active, touchend .skill .button.active': (event) ->
    Meteor.call "useSkill", @_id
    event.stopPropagation()
    false


Meteor.startup ->

  Session.set 'earnedExperience', null

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