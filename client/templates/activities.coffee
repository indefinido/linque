@DaysActivities = new Mongo.Collection "daysActivities"

moment.locale 'pt-BR', 
  calendar:
    lastDay  : '[Ontem]'
    sameDay  : '[Hoje]'
    nextDay  : '[Amanhã]'
    lastWeek : 'dddd'
    nextWeek : 'dddd [que vem]'
    
  monthsShort: "Jan_Fev_Mar_Abr_Mai_Jun_Jul_Ago_Set_Out_Nov_Dez".split("_"),
  weekdays: "Domingo_Segunda_Terça_Quarta_Quinta_Sexta_Sábado".split("_")
  weekdaysShort: "Dom._Seg._Ter._Qua._Qui._Sex._Sáb.".split("_")
    
moment.locale 'pt-BR'



Template.activities.helpers
  daysActivities: ->
    DaysActivities.find {},
      sort:
        _id: -1
    
    
Template.day.helpers
  activities: ->
    @activities
    
  calendarDate: -> 
    if moment(@date) > moment().subtract(2, 'days')
      moment(@date).calendar()
    else
      false
    
  formattedDate: ->
    moment(@date).format('dddd[,] D/MMM/YY')

        
Template.activity.helpers
  createdAt: ->
    moment(@createdAt).format 'H:mm'
    
    
    
    
Meteor.startup ->
  Meteor.subscribe "activities"