@DaysActivities = new Mongo.Collection "daysActivities"

moment.locale 'pt-BR', 
  calendar:
    lastDay  : '[Yesterday]'
    sameDay  : '[Today]'
    nextDay  : '[Tomorrow]'
    lastWeek : 'dddd'
    nextWeek : 'dddd que vem'



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
    
  _id: ->
    moment(@_id).calendar()

        
Template.activity.helpers
  createdAt: ->
    moment(@createdAt).format 'LT'
    
    
    
    
Meteor.startup ->
  Meteor.subscribe "activities"