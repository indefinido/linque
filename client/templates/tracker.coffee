## Events

Template.tracker.events

  'click track-button': _.debounce (event) ->
    Meteor.call "track"
  , 150
