class Dot
  
  constructor: (type = 'empty', @body, @heading) ->
    @setType type
    @heading ||= "#{@type} Dot"

  setType: (type) ->
    @[$.camelCase 'is-' + type] = true
    @type = type


Template.pathway.helpers
  dots: ->
    i = 50
    dots = []
    
    while (i--)
      dot = new Dot
      dot.setType 'tip' if i % 7 == 0
      dots.unshift dot
    
    dots.unshift new Dot 'storyEvent', "Acontecimento misterioso na timeline"
    dots.unshift new Dot 'warning', "Você não pode comer sua garrafa!"
    dots.unshift new Dot 'tip', "Você deveria fazer sua garrafa durar um dia"
    dots.unshift new Dot 'decisionPoint', "Essa não tem corpo de mensagem provavelmente"
    dots.unshift new Dot 'user'

    i = 10
    while (i--)
      dot = new Dot
      dot.setType 'tip' if i % 7 == 0
      dots.unshift dot
      
    dots
