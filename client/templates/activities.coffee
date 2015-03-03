@DaysActivities = new Mongo.Collection "daysActivities"

moment.locale 'en', 
  calendar:
    lastDay  : '[Ontem]'
    sameDay  : '[Hoje]'
    nextDay  : '[Amanhã]'
    lastWeek : 'dddd'
    nextWeek : 'dddd [que vem]'



Template.activities.helpers
  daysActivities: ->
    DaysActivities.find {},
      fields:
        activities: 0
      sort:
        _id: -1
    
    
Template.day.helpers
  activities: ->
    DaysActivities.findOne({_id: @_id}).activities
    
  calendarDate: -> 
    moment(@date).calendar()
    
  formattedDate: ->
    moment(@date).format('D/MMM/YY')

        
Template.activity.helpers
  createdAt: ->
    moment(@createdAt).format 'LT'
    
    
    
    
Meteor.startup ->
  Meteor.subscribe "activities"