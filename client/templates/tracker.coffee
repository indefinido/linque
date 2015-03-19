## Events

Template.tracker.events

  # FIXME event being fired twice in touch devices
  # Implement tracker events
  'click .skill .button.active': (event) ->
    Meteor.call "useSkill", @_id
    event.stopPropagation()
    false
