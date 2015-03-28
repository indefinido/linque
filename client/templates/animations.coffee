share.animator =
  initialize: ->
    animations = @findAll 'core-animation'
    _.each animations, (animation) ->
      @animations[animation.id] = animation
    , share.animator
    
  target: null
  animations: {}
  clear: (animation) ->
    {target} = animation
    
    classes  = target.getAttribute 'class'
    target.setAttribute 'class', classes.replace 'core-animation-target', ''
    
    animation.target = null
  
  pulse: (target, movement = true) ->
    {pulse}      = @animations
    if movement
      pulse.target = target
      pulse.play()
    else
      @clear pulse
      pulse.cancel()

  blink: (target, movement = true) ->
    {blink}      = @animations
    if movement
      blink.target = target
      blink.play()
    else
      @clear blink
      blink.cancel()
      
  bounscale: (target) ->    
    animation = new CoreAnimation
    animation.duration = 1800
    animation.keyframes = [
      { transform: 'scale(4.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(-0.7em, 0   ) rotate(-20deg)' }
      { transform: 'scale(3.0) translate(0.7em , 0   ) rotate(20deg)'  }
      { transform: 'scale(3.0) translate(-0.7em, 0   ) rotate(-20deg)' }
      { transform: 'scale(3.0) translate(0.7em , 0   ) rotate(20deg)'  }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(3.0) translate(0     , 0   ) rotate(0)'      }
      { transform: 'scale(1.0) translate(0     , 0   ) rotate(0)'      }
    ]
    animation.target = target
    animation.play()
    
      
  presentTo: (target) ->
    container = $ 'html, body'
    target    = $ target
    container.scrollTop(0)
    container.animate
      scrollTop: document.body.scrollHeight
      , 1000
      , ->
        container.delay(700).animate
          scrollTop: target.offset().top - $(window).height() + target.height()*1.5
          , 1000

Template.animations.onRendered share.animator.initialize
