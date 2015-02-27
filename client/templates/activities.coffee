Template.activities.helpers
  activities: -> Activities.find {}

Template.activity.helpers  
  description: -> JSON.stringify @data