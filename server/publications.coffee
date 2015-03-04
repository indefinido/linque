Meteor.publish "user", ->
  return @ready() unless @userId

  Meteor.users.find { _id: @userId },
    fields:
      experience: 1
      levelExperience: 1
      level: 1
      skills: 1
      profile: 1



Meteor.publish "skills", ->
  return @ready() unless @userId

  Skills.find {},
    sort:
      order: 1




Meteor.publish "levels", ->

  Levels.find {},
    sort:
      _id: 1




# server: publish the current size of a collection
Meteor.publish 'activities', ->

  self = @

  activities = Activities.find { userId: this.userId, type: "skillUse" },
    fields:
      createdAt: 1
      data: 1
    sort:
      createdAt: -1
  .fetch()


  dayActivities = _.groupBy activities, (activity) ->
    moment(activity.createdAt).format('D/MMM/YY')


  initializing = true


  handle = Activities.find(userId: this.userId, type: "skillUse" ).observeChanges
    added: (id, fields) ->

      date = moment(fields.createdAt).format('D/MMM/YY')

      fields.id = id

      # merge activity to day activity and mark as changed
      if dayActivities[date]
        if !initializing
          dayActivities[date].unshift fields
          self.changed 'daysActivities', date, activities: dayActivities[date]

      # create first day activity and mark as added
      else
        dayActivities[date] = [ fields ]
        dateObject = moment fields.createdAt

        self.added 'daysActivities', date,
          activities: dayActivities[date]
          date:
            year : dateObject.year()
            month: dateObject.month()
            day  : dateObject.date()



  initializing = false

  for timestamp, activities of dayActivities
    date  = moment(timestamp).format('D/MMM/YY')
    today = moment().format('D/MMM/YY')

    # report all current activities
    @added 'daysActivities', date,
      activities: activities

    # delete activities that happened before today
    delete dayActivities[date] if date isnt today


  @ready()

  # Stop observing the cursor when client unsubs.
  # Stopping a subscription automatically takes
  # care of sending the client any removed messages.
  @onStop ->
    handle.stop()
    return

  return




# Meteor.publish "activities", ->
#   return @ready() unless @userId
#
#   Activities.find { userId: this.userId, type: "skillUse" },
#     fields:
#       createdAt: 1
#       data: 1
#     sort:
#       createdAt: -1
#
#
