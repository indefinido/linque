{animator} = share

mover = undefined

domable =
  element: (dot = @dot) ->
    holder  = $ "linque-path > linque-dot:nth-last-child(#{dot.position})"
    console.error("moverable.move: Target dot not found with position: #{dot.position}") unless holder.length
      
    @holder = holder.get(0)

moverable =
  dot: null
  holder: null
  freed: null
  userView: null

  initialize: (@dot) ->
    opener.target = @element()

    # Free without opening
    if @freed = not @holder.getAttribute('free')?
      @holder.setAttribute 'free', true
      @holder.classList.add 'current'
    
    @positionate()
  
  move: (dot) ->
    # Remove old dot settings
    @remove() if @holder

    # Find new dot
    @dot          = dot
    @element()
    opener.target = @holder
    
    @positionate()
  
  arrive: ->
    if @freed = not @holder.getAttribute('free')?
      @holder.setAttribute 'free', true
      @holder.classList.add 'current'

    opener.open @dot
    
  # remove user from current dot
  remove: ->
    Blaze.remove @userView
    
    @holder.removeAttribute 'free'     if @freed
    @holder.classList.remove 'current'
    opener.close @dot if @holder.hasAttribute 'opened' 

    
  # put user in position
  positionate: ->
    @userView = Blaze.render Template.character, @holder
    @arrive()

opener =
  target: null
  open: (dot) ->
    $('#dashboard').addClass 'consoling'
    switch dot.type
      when 'decision'
        @target.setAttribute 'opened', true
        animator.pulse @target.querySelector '.user .user-circle'
      when 'warning'
        @target.setAttribute 'opened', true
        # TODO simplify query, maybe store next dot on current dot?
        holder = domable.element Dots.find(type: 'decision', _id: {$gt: dot.position}).fetch()[0]
        animator.blink holder.querySelector '#circle'
      else
        @target.setAttribute 'opened', true
  
  close: (dot) ->
    $('#dashboard').removeClass 'consoling'
    switch dot.type
      when 'decision'
        @target.removeAttribute 'opened'
        animator.pulse @target.querySelector('.user .user-circle'), false
      when 'warning'
        @target.removeAttribute 'opened'
        # TODO simplify query, maybe store next dot on current dot?
        holder = domable.element Dots.find(type: 'decision', _id: {$gt: dot.position}).fetch()[0]
        animator.blink holder.querySelector('#circle'), false
      else
        @target.removeAttribute 'opened'
    
emptyDotable =
  _id: null
  type: 'empty'
  isEmpty: true
  completed: false


control =

  initialize: (@template) ->
    mover = $.extend {}, moverable, domable
    
    Tracker.afterFlush @initialMovement
    
  findOrBuildDot: (user) ->
    # Search for user current position
    dot = Dots.find(_id: user.position).fetch()[0]
  
    # User is not in any actionable dot, use an empty dot in his current position
    dot = _.extend position: user.position, emptyDotable unless dot

    
    dot

  initialMovement: ->
    return unless user = Meteor.user()

    dot = control.findOrBuildDot user
    
    mover.initialize dot

    control.template.autorun control.movement

  movement: (computation) ->
    # Must be first line in order to allow Tracker to detect it's subscription
    return unless user = Meteor.user()
    
    return if computation.firstRun
    
    # TODO listen to only position changes in user
    if mover.dot.position == user.position
      return console.warn 'Trying to control.movement to current dot'

    mover.move control.findOrBuildDot user

Template.pathway.onRendered ->
  @subscribe 'dots', [], => control.initialize @

Template.pathway.helpers
  dots: ->
    user         = Meteor.user()
    userPosition = user.position
    dots         = Dots.find({}).fetch()
    i            = dots.length - 1
    j            = 1
    path         = []

    # When there is no dots in database, do not try to render them
    return path unless dots.length

    previous = dots.shift()
    previous.completed = userPosition > j++
    path.push previous

    while (i--) 
      next           = dots.shift()
      empty          = next.position - previous.position
      next.completed = userPosition > j

      
      while (--empty)
        path.push _.extend {}, emptyDotable, 
          _id      : "empty-#{i}-#{empty}"
          completed: userPosition > j
          
        j++

      path.push        next
      previous       = next
      j++


    # TODO implement path construction in the right order
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
      options.push
        # Rule decision data
        id: id
        current: levels.shift()
        next: levels.shift()

        # Dot data
        type: 'decision'
        position: user.position

    options[0].splited = true

    options
      
      
      
Template.pathway.events
  # This method handles all modal closings. In all cases, except the decision
  # modal the handler context is a dot. On decision modal the context is the
  # rule option with some decision dot available data
  'click core-overlay paper-button:not([disabled])': (event, template) ->
    # Send rule id to compute user decision on decision overlays
    Meteor.call 'decide', @id if @type == 'decision'

    # Clos edecision overlay
    opener.close @

