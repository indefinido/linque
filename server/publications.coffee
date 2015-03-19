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


# TODO remove: Waiting to make sure we will not use when user reachs a decision point
Meteor.publish "skillLevelUps", () ->
  self = @
  initializing = true
  
  handle = Activities.find( userId: this.userId, type: "skillLevelUp").observeChanges
    added: (id, fields) ->
      if !initializing
        self.added 'skillLevelUps', id, _.extend fields
      
  initializing = false
  @ready()
  @onStop -> handle.stop()
