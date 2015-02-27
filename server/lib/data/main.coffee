records = @records ||= {}

Meteor.startup () ->
  _.each _.keys(records), (name) ->
    collection = global[name]
    console.log
    _.each records[name], (record) -> 
      console.log "Upserting #{name}: #{record._id}"
      collection.upsert { _id: record._id }, record
    
delete @records 