records = @records ||= {}

Meteor.startup () ->
  for name in _.keys(records)
    collection = global[name]
    for record in records[name]
      console.log "Upserting #{name}: #{record._id}"
      collection.upsert { _id: record._id }, record
    
delete @records 