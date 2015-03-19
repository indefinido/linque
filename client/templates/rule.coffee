# TODO lock rule if it is on maximun level
Template.rule.helpers

  id      : -> @_id

  level   : -> Meteor.user().rules[@_id].level

  # rule can level up?
  levelable: -> @levelable()
