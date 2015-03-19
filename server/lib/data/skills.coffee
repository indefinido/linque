@records ||= {}

@records.Skills = [
    _id: 'container'
    activity: 'passive'
    name: "Possuir um recipiente de"
    order: 2
    levels: [
        qualifier: "250 ml"
        summary: "Você pode ter apenas um Copo de volume de 250 ml"
        description: ""
        requiredLevel: 1
        level: 1 
      ,
        qualifier: "600 ml"
        summary: "Você pode ter apenas uma Garrafa de volume de até 500 ml"
        description: ""
        requiredLevel: 3
        level: 2
      ,
        qualifier: "1 L"
        summary: "Você pode ter apenas uma Garrafa de volume de até 1 L"
        description: ""
        requiredLevel: 4
        level: 3
      ,
        qualifier: "1,5 L"
        summary: "Você pode ter apenas uma Garrafa de volume até 1,5 L"
        description: ""
        requiredLevel: 5
        level: 4
    ]
  ,
    _id: 'fill'
    activity: 'passive'
    name: "Encher recipiente"
    order: 1
    levels: [
        qualifier: "1x / dia"
        summary: "Você pode encher seu recipiente atual apenas 1 vez por dia."
        description: ""
        experience: 75
        requiredLevel: 1
        level: 1
      ,
        qualifier: "2x / dia"
        summary: "Você pode encher seu recipiente atual até 2 vezes por dia."
        description: ""
        experience: 75
        requiredLevel: 4
        level: 2
      ,
        qualifier: "Livre"
        summary: "Você pode encher seu recipiente quantas vezes quiser no mesmo dia (cuidado para não tomar água em excesso!)."
        description: ""
        experience: 75
        requiredLevel: 5
        level: 3
    ]
  ,
    _id: 'trigger'
  ,
    _id: 'drink'
    activity: 'active'
    name: "Beber Água"
    order: 4
    levels: [
        qualifier: "Pouco"
        summary: "Você pode beber pouca água. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 2
        level: 1
      ,
        qualifier: "Médio"
        summary: "Você pode beber um pouco mais de água do que antes. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 3
        level: 2
      ,
        qualifier: "Mais"
        summary: "Você pode beber mais água do que antes. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 4
        level: 3
      ,
        qualifier: "Livre"
        summary: "Você pode beber quanta água quiser ao receber um gatilho. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 5
        level: 4
    ]
]
