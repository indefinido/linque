Meteor.publish "user", ->
  return @ready() unless @userId

  Meteor.users.find { _id: @userId },
    fields:
      position: 1
      rules: 1

      # We use profile picture
      profile: 1

      # To send email for olark
      "services.google": 1
      "services.facebook.email": 1

Meteor.publish "rules", ->
  return @ready() unless @userId

  Rules.find {}, sort: {order: 1}

