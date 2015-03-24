Meteor.subscribe 'dots'

dot =
  empty:
    type: 'empty'
    isEmpty: true

Template.pathway.helpers
  dots: ->
    dots     = Dots.find().fetch()
    i        = dots.length - 1
    path     = []

    previous = dots.shift()
    path.push previous
    
    while (i--)
      next  = dots.shift()
      empty = next.position - previous.position

      while (empty--)
        path.push dot.empty
      
      path.push next
 

    # TODO implement path construction in the write order
    path.reverse()
    path
