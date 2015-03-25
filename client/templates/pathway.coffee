Meteor.subscribe 'dots'

moverable =
  move: (userDot) ->
    @remove() if @userDot
    @userDot = userDot
    @positionate()
  
  # remove user from current dot
  remove: ->
    Blaze.remove @userView
    
    @userDot.removeAttribute 'free'   if @freed
    @userDot.removeAttribute 'opened' if @opened

  arrive: ->
    if @freed = not @userDot.getAttribute('free')?
      @userDot.setAttribute 'free', true

    if @opened = not @userDot.getAttribute('opened')?
      @userDot.setAttribute 'opened', true
        
  # put user in position
  positionate: ->
    @arrive()
    @userView = Blaze.render Template.character, @userDot

 
Template.pathway.onRendered ->
  # First mover
  mover = Object.create moverable,
    move: value: ->
      moverable.move.apply @, arguments
      
      # TODO forward own properties except functions
      moverable.userView = @userView
      moverable.userDot  = @userDot

      # Overrides mover after first movement. Maybe it is not his responsibility
      # to execute the dot action?
      mover = moverable
      
    # put user in position
    arrive: value: ->
      if @freed = not @userDot.getAttribute('free')?
        @userDot.setAttribute 'free', true
  
  @autorun ->
    return unless user = Meteor.user()
    dot = $ "linque-path > linque-dot:nth-last-child(#{user.position})"
    mover.move dot.get(0)


dot =
  empty:
    type: 'empty'
    isEmpty: true

Template.pathway.helpers
  dots: ->
    user         = Meteor.user()
    userPosition = user.position
    dots         = Dots.find({}).fetch()
    i            = dots.length - 1
    j            = 1
    path         = []

    previous = dots.shift()
    previous.completed = userPosition > j++
    path.push previous

    while (i--) 
      next           = dots.shift()
      empty          = next.position - previous.position
      next.completed = userPosition > j

      
      while (--empty)
        path.push _.extend {}, dot.empty, 
          _id      : "empty-#{i}-#{empty}"
          completed: userPosition > j
          
        j++

      path.push        next
      previous       = next
      j++


    # TODO implement path construction in the write order
    path.reverse()
    path

  # Render rule options for the decision modal
  options: ->
    user    = Meteor.user()
    options = []

    for id, rule of user.rules
      definition  = Rules.find({_id: id}).fetch()[0]
      
      # Pick only the next two levels for the current user Rule
      levels      = _.filter definition.levels, (level) ->
        level.number == rule.level || level.number == rule.level + 1

      # Update view with levels
      options.push {id: id, current: levels.shift(), next: levels.shift()}

    options[0].splited = true

    options
      
Template.pathway.events
  # TODO Take advantage of event bubbling
  'click paper-button.decision-rule-next': (event, template) ->
    Meteor.call 'decide', this.id
    _.defer =>
      # TODO check why linque-dot.opened = false is not working 
      $(event.target).parents('core-overlay').get(0).close()
    , 10
