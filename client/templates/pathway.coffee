Meteor.subscribe 'dots'
{animator} = share

domable =
  element: (dot = @dot) ->
    holder  = $ "linque-path > linque-dot:nth-last-child(#{dot.position})"
    unless holder.length
      console.error("moverable.move: Target dot not found with position: #{dot.position}")
      # debugger
      
    @holder = holder.get(0)

moverable =
  dot: null
  holder: null
  freed: null
  userView: null
  
  move: (@dot) ->
    @remove() if @holder
    opener.target = @element()
    
    @positionate()
  
  arrive: ->
    debugger unless @holder
    if @freed = not @holder.getAttribute('free')?
      @holder.setAttribute 'free', true
      @holder.addClass 'current'

    opener.open @dot
    
  # remove user from current dot
  remove: ->
    Blaze.remove @userView
    
    @holder.removeAttribute 'free' if @freed
    @holder.removeClass 'current'

    
  # put user in position
  positionate: ->
    @arrive()
    @userView = Blaze.render Template.character, @holder

opener =
  target: null
  open: (dot) ->
    $('#dashboard').addClass 'consoling'
    switch dot.type
      when 'warning'
        @target.setAttribute 'opened', true
        # TODO simplify query, maybe store next dot on current dot?
        holder = domable.element Dots.find(type: 'decision', _id: {$gt: dot.position}).fetch()[0]
        animator.blink holder, true
      when 'decision'
        @target.setAttribute 'opened', true
        animator.pulse $('.user-circle').get(0), true
      else
        @target.setAttribute 'opened', true
        
        
  
  close: (dot) ->
    $('#dashboard').removeClass 'consoling'
    switch dot.type
      when 'warning'
        @target.setAttribute 'opened', false
        # TODO simplify query, maybe store next dot on current dot?
        holder = domable.element Dots.find(type: 'decision', _id: {$gt: dot.position}).fetch()[0]
        animator.blink holder, false
      when 'decision'
        @target.setAttribute 'opened', false
        animator.pulse $('.user-circle').get(0), false
      else
        @target.setAttribute 'opened', false
    
emptyDotable =
  _id: null
  type: 'empty'
  isEmpty: true
  completed: false




Template.pathway.onRendered ->
  mover    = $.extend {}, moverable, domable,
    move: ->
      moverable.move.apply @, arguments
      
      mover = $.extend {}, moverable, domable, 
        dot      : @dot
        holder   : @holder
        freed    : @freed
        userView : @userView
      
    arrive: ->
      debugger unless @holder
      if @freed = not @holder.getAttribute('free')?
        @holder.setAttribute 'free', true
        @holder.classList.add 'current'
      

  user = Meteor.user()
  
  @autorun ->
    return unless user

    # Search for user current position
    dot = Dots.find(_id: user.position).fetch()[0]

    # User is not in any actionable dot, use an empty dot in his current position
    dot = _.extend position: user.position, emptyDotable unless dot

    return unless domable.element dot
    
    # TODO listen to only position changes in user
    if mover.dot?.position == user.position
      return console.warn 'Trying to move to the already positioned dot'

    mover.move dot




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
        path.push _.extend {}, emptyDotable, 
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

    # Close decision overlay
    opener.close @

