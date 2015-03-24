Meteor.publish "user", ->
  return @ready() unless @userId

  Meteor.users.find { _id: @userId },
    fields:
      rules: 1

      # We use profile picture
      profile: 1

      # To send email for olark
      "services.google": 1
      "services.facebook.email": 1

Meteor.publish "movement", ->
  Meteor.users.find({ _id: @userId }).observeChanges
    changed: (id, fields) => @changed 'users', id, fields

  @ready()

Meteor.publish "rules", ->
  return @ready() unless @userId

  Rules.find {}, sort: {order: 1}

Meteor.publish "dots", ->
  return @ready() unless @userId

  Dots.find {}, sort: {position: 1}

