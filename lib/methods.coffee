meta =
  insertActivity: (user, data) ->
    # Record skill usage
    Activities.insert
      userId: user._id
      createdAt: new Date
      type: 'track'
      data: data
      
  logTrack: (user) ->
    @insertActivity user, position: user.position
    
        

Meteor.methods
  track: () ->
    user  = Meteor.user()

    meta.logTrack user

    # update user position
    Meteor.users.update { _id: user._id },
      $inc:
        position: 1

    # update user variable
    user = Meteor.user()


    # Report earned experience to client
    # if Meteor.isClient
    #   Session.set 'earnedExperience', earnedExperience

    # Report earned experience to client
    # TODO move to a analytics special place
    if Meteor.isClient && Meteor.env != 'development'
      GAnalytics.event 'Trigger', 'Register', "newPosition: #{user.position}"
