records = @records ||= {}

Meteor.startup () ->
  for name in _.keys(records)
    collection = global[name]
    console.log "droped collection #{name} - removed #{collection.remove({})} records."

    for record in records[name]
      message  = "insert one of the #{name}: #{record._id}"
      message += " - " + record.type if record.type
      console.log message
      result = collection.upsert { _id: record._id }, record
      
      console.log "Failed to insert #{record._id}" unless result.numberAffected
    
delete @records 
