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
    
    dots.push new Dot 'storyEvent', "Acontecimento misterioso na timeline"
    dots.push new Dot 'warning', "Você não pode comer sua garrafa!"
    dots.push new Dot 'tip', "Você deveria fazer sua garrafa durar um dia"
    dots.push new Dot 'decisionPoint', "Essa não tem corpo de mensagem provavelmente"
    dots.push new Dot 'user'

    while (i--)
      dot = new Dot
      dot.setType 'tip' if i % 7 == 0
      dots.push dot
      


    dots
