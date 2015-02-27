Meteor.publish "user", ->
  return @ready() unless @userId

  Meteor.users.find { _id: @userId },
    fields: 
      experience: 1
      levelExperience: 1
      level: 1
      skills: 1

    
    
Meteor.publish "skills", ->
  return @ready() unless @userId
  
  skills = Skills.find {}, 
    sort: 
      activity: 1
      _id: 1
  
  
      
      
Meteor.publish "levels", ->
  
  Levels.find {},
    sort:
      _id: 1
      
      
Meteor.publish "activities", ->
  return @ready() unless @userId
  
  Activities.find { userId: this.userId }
  