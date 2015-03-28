@Dot = 
  typefy: (type) ->
    if type
      @[$.camelCase 'is-' + type] = true unless Meteor.isServer
      @type = type
    else
      @type

@Dots = new Mongo.Collection 'dots', transform: (doc) ->
  instance          = _.extend Object.create(Dot), doc
  instance.position = doc._id
  instance.typefy     doc.type
  instance
  
