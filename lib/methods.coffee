meta =
  insertActivity: (user, type, data) ->
    # Record skill usage
    Activities.insert
      userId: user._id
      createdAt: new Date
      type: type
      data: data
      
  logTrack: (user, position) ->
    @insertActivity user, 'track', position: position

  logDecision: (user, id) ->
    @insertActivity user, 'decision', rule: id

  analytics: (category, action, label) ->
    return unless Meteor.isClient && Meteor.env != 'development'
    GAnalytics.event category, action, label



Meteor.methods
  track: ->
    user     = Meteor.user()
    position = user.position

    # update user position
    Meteor.users.update { _id: user._id },
      $inc:
        position: 1

    meta.logTrack user, position
    meta.analytics 'Routine', 'Track', "position: #{position}"
      
  decide: (id) ->
    user = Meteor.user()

    # check if user is on decision dot
    dot  = Dots.find(_id: user.position).fetch()[0]
    throw "User is on invalid dot to make decision. User position: #{user.position}, dot: #{dot && dot.position} #{dot.type}" unless dot && dot.type == 'decision'
    

    # update user rule level
    operation = $inc: {}
    operation.$inc["rules.#{id}.level"] = 1
    Meteor.users.update { _id: user._id }, operation

    # log user decision
    meta.logDecision user, id
    meta.analytics 'Decision', 'Rule', "id: #{id}, level: #{user.rules[id].level}"
    
