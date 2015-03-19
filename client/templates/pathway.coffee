class Dot
  
  constructor: (type = 'empty', @body, @heading) ->
    @setType type
    @heading ||= "#{@type} Dot"

  setType: (type) ->
    @[$.camelCase 'is-' + type] = true
    @type = type


Template.pathway.helpers
  dots: ->

    dots = []
    
    dots.unshift new Dot for i in [1..50]
    
    dots.unshift new Dot 'storyEvent', "Acontecimento misterioso na timeline"
    dots.unshift new Dot 'warning', "Você não pode comer sua garrafa!"
    dots.unshift new Dot 'decisionPoint', "Essa não tem corpo de mensagem provavelmente"
    dots.unshift new Dot 'user'
    dots.unshift new Dot 'tip', "Você deveria fazer sua garrafa durar um dia"

    i = 10
    while (i--)
      dot = new Dot
      dot.setType 'tip' if i % 7 == 0
      dots.unshift dot
      
    dots
