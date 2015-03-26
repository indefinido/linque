share.animator =
  initialize: ->
    animations = @findAll 'core-animation'
    _.each animations, (animation) ->
      @animations[animation.id] = animation
    , share.animator
    
  target: null
  animations: {}
    
  pulse: (target, movement = true) ->
    {pulse}      = @animations
    if movement
      pulse.target = target
      pulse.play()
    else
      pulse.target.classList.toggle 'core-animation-target', false
      pulse.target = null
      pulse.cancel()

  blink: (target, movement = true) ->
    {blink}      = @animations
    if movement
      blink.target = target
      blink.play()
    else
      blink.target.classList.toggle 'core-animation-target', false
      blink.target = null
      blink.cancel()
      
  presentTo: (target) ->
    container = $('html, body')
    container.scrollTop(0)
    container.animate
      scrollTop: document.body.scrollHeight
      , 1000
      , ->
        container.delay(700).animate
          scrollTop: $(target).offset().top - $(window).height() + $(target).height()*1.5
          , 1000
    
Template.animations.onRendered share.animator.initialize
