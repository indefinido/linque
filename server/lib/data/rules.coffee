@records ||= {}

@records.Rules = [
    _id: 'container'
    levels: [
        summary: "Você pode ter apenas um Copo de volume de 250 ml"
        level: 1 
      ,
        summary: "Você pode ter apenas uma Garrafa de volume de até 500 ml"
        level: 2
      ,
        summary: "Você pode ter apenas uma Garrafa de volume de até 1 L"
        level: 3
      ,
        summary: "Você pode ter apenas uma Garrafa de volume até 1,5 L"
        level: 4
    ]
  ,
    _id: 'fill'
    levels: [
        summary: "Você pode encher seu recipiente atual apenas 1 vez por dia."
        level: 1
      ,
        summary: "Você pode encher seu recipiente atual até 2 vezes por dia."
        level: 2
      ,
        summary: "Você pode encher seu recipiente quantas vezes quiser no mesmo dia (cuidado para não tomar água em excesso!)."
        level: 3
    ]
]
