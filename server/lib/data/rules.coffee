@records ||= {}

@records.Rules = [
    _id: 'container'
    levels: [
        qualifier: "250 ml"
        summary: "Você pode ter apenas um Copo de volume de 250 ml"
        number: 1 
      ,
        qualifier: "600 ml"
        summary: "Você pode ter apenas uma Garrafa de volume de até 500 ml"
        number: 2
      ,
        qualifier: "1 L"
        summary: "Você pode ter apenas uma Garrafa de volume de até 1 L"
        number: 3
      ,
        qualifier: "1,5 L"
        summary: "Você pode ter apenas uma Garrafa de volume até 1,5 L"
        number: 4
      ,
        qualifier: "Livre"
        summary: "Você pode usar o recipiente que quiser quando achar melhor."
        number: 5
    ]
  ,
    _id: 'fill'
    levels: [
        qualifier: "1x / dia"
        summary: "Você pode encher seu recipiente atual apenas 1 vez por dia."
        number: 1
      ,
        qualifier: "2x / dia"
        summary: "Você pode encher seu recipiente atual até 2 vezes por dia."
        number: 2
      ,
        qualifier: "3x / dia"
        summary: "Você pode encher seu recipiente atual até 3 vezes por dia."
        number: 3
      ,
        qualifier: "4x / dia"
        summary: "Você pode encher seu recipiente atual até 4 vezes por dia."
        number: 4
      ,
        qualifier: "Livre"
        summary: "Você pode encher seu recipiente quantas vezes quiser no mesmo dia (cuidado para não tomar água em excesso!)."
        number: 5
    ]
]
