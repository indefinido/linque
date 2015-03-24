Meteor.subscribe 'dots'



mover =
        
  move: ->
    @remove()
    @position()
  
  # remove user from current dot
  remove: ->
    return unless @userDot
    
    @userDot.removeAttribute 'free' if @setFree
    Blaze.remove @userView 
    
  # put user in position
  position: ->
    interval = Meteor.setInterval $.proxy(->
      return unless @userDot = $("linque-path > linque-dot:nth-last-child(#{Meteor.user().position})").get(0)
      Meteor.clearInterval interval
      
      if @setFree = not @userDot.getAttribute('free')?
        @userDot.setAttribute 'free', true
      
      @userView = Blaze.render Template.character, @userDot
    , @), 10
    
    
    
Template.pathway.onRendered ->

  @autorun ->
    return unless Meteor.user()
    mover.move()




dot =
  empty:
    type: 'empty'
    isEmpty: true

Template.pathway.helpers
  dots: ->
    user     = Meteor.user()
    dots     = Dots.find({}, sort: { _id: 1 }).fetch()
    i        = dots.length - 1
    j        = 1
    path     = []

    previous = dots.shift()
    path.push previous

    while (i--)
      next  = dots.shift()
      empty = next.position - previous.position

      while (--empty)
        path.push _.extend {}, dot.empty, 
          _id      : "empty-#{i}-#{empty}"
          completed: user.position >= j
        j++

      path.push next
      j++


    # TODO implement path construction in the write order
    path.reverse()
    path


