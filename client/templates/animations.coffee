manager =
  animations: {}

  initialize: ->
    
    elements = @findAll 'core-animation'
    _.each elements, (animation) ->
      @animations[animation.id] = animation
    , manager

    bounscale = new CoreAnimation
    bounscale.delay     = 1000
    bounscale.duration  = 1800
    bounscale.keyframes = [
      { transform: 'scale(4.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(-0.7em, 0   ) rotate(-20deg )' }
      { transform: 'scale(3.0) translate(0.7em , 0   ) rotate(20deg  )' }
      { transform: 'scale(3.0) translate(-0.7em, 0   ) rotate(-20deg )' }
      { transform: 'scale(3.0) translate(0.7em , 0   ) rotate(20deg  )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0      )' }
      { transform: 'scale(1.0) translate(0     , 0   ) rotate(0      )' }
    ]

    manager.animations.bounscale = bounscale

  presented: false
  
  clear: (animation) ->
    {target} = animation
    
    classes  = target.getAttribute 'class'
    target.setAttribute 'class', classes.replace /\s?core-animation-target/, ''
    
    animation.target = null

  finished: (event) ->
    {target: animation} = event
    manager.clear animation
    animation.removeEventListener @finished

animator =
  animations: manager.animations

  pulse: (target, movement = true) ->
    {pulse}      = @animations
    if movement
      pulse.target = target
      pulse.play()
    else
      manager.clear pulse
      pulse.cancel()

  blink: (target, movement = true) ->
    {blink}      = @animations
    if movement
      blink.target = target
      blink.play()
    else
      manager.clear blink
      blink.cancel()

  bounscale: (target) ->
    {bounscale} = @animations
      
    bounscale.addEventListener 'core-animation-finish', manager.finished
      
    bounscale.target = target
    bounscale.play()

  centerTo: (target) ->
    # TODO improve
    return unless manager.presented
    
    container = $ 'html, body'
    target    = $ target

    Tracker.afterFlush ->
      container.animate
        scrollTop: target.offset().top - $(window).height() + target.height() * 1.5
      , 1000

  presentTo: (target) ->
    container = $ 'body'
    target    = $ target
    
    container.scrollTop 0

    Tracker.afterFlush ->
      container.delay(1000).animate
        scrollTop: document.body.scrollHeight
        , 1500
        , ->
          container.delay(1000).animate
            scrollTop: target.offset().top - $(window).height() + target.height() * 1.5
            , 1000
    
          # TODO improve
          manager.presented = true

Template.animations.onRendered ->
  document.addEventListener 'polymer-ready', => manager.initialize.call @
  
share.animator = animator
