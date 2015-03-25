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
    pulse.target = target
    pulse[if movement then 'play' else 'cancel']()

  blink: (target, movement = true) ->
    {blink}      = @animations
    blink.target = target
    blink[if movement then 'play' else 'cancel']()

Template.animations.onRendered share.animator.initialize
