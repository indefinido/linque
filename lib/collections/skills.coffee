skill = 
  active: ->
    @activity == 'active'

  levelable: ->
    @levels.length > 1

@Skills = new Mongo.Collection 'skills', transform: (doc) ->
  _.extend Object.create(skill), doc
  
