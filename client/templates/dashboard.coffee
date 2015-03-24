Meteor.subscribe "rules"

## Helpers

Template.dashboard.helpers
  rules: ->
    Rules.find().fetch()


Meteor.startup ->
  
  # TODO figure out why this is not on template
  $('body').attr 'fullbleed', true  
  
  
