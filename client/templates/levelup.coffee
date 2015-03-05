Template.levelup.helpers
  level: ->
    Meteor.user().level
    
    



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
      $('#levelup-dialog').get(0).open() 

    Session.set 'level', nextLevel
    
    