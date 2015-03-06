@records ||= {}

@records.Skills = [
    _id: 'container'
    activity: 'passive'
    name: "Possuir um Recipiente"
    order: 2
    levels: [
        qualifier: "Copo Pequeno"
        summary: "Você pode ter apenas um Copo de volume entre 200 ml e 300 ml"
        description: ""
        requiredLevel: 1
        level: 1
      ,
        qualifier: "Garrafa Pequena"
        summary: "Você pode ter apenas uma Garrafa de volume entre 500 ml e 600 ml"
        description: ""
        requiredLevel: 3
        level: 2
      ,
        qualifier: "Garrafa Média"
        summary: "Você pode ter apenas uma Garrafa de volume entre 900 ml e 1100 ml (1,1 L)"
        description: ""
        requiredLevel: 4
        level: 3
      ,
        qualifier: "Garrafa Grande"
        summary: "Você pode ter apenas uma Garrafa de volume entre 1,4 L e 1,6 L"
        description: ""
        requiredLevel: 5
        level: 4
    ]
  ,
    _id: 'trigger'
    activity: 'passive'
    name: "Receber Gatilho"
    order: 3
    levels: [
        summary: "Você sabe receber gatilhos do ambiente. Use a habilidade de Beber Água sempre que beber água imediatamente após receber um gatilho."
        description: ""
        requiredLevel: 2
        level: 1
    ]
  ,
    _id: 'fill'
    activity: 'active'
    name: "Encher Recipiente"
    order: 1
    levels: [
        qualifier: "1 vez por dia"
        summary: "Você pode encher seu recipiente atual apenas 1 vez por dia. Use esta habilidade para registrar todas as vezes que você encheu seu recipiente."
        description: ""
        experience: 100
        requiredLevel: 1
        level: 1
      ,
        qualifier: "2 vezes por dia"
        summary: "Você pode encher seu recipiente atual até 2 vez por dia. Use esta habilidade para registrar todas as vezes que você encheu seu recipiente."
        description: ""
        experience: 75
        requiredLevel: 3
        level: 2
      ,
        qualifier: "Quantas vezes quiser"
        summary: "Você pode encher seu recipiente quantas vezes quiser no mesmo dia (cuidado para não tomar água em excesso!). Use esta habilidade para registrar todas as vezes que você encheu seu recipiente."
        description: ""
        experience: 75
        requiredLevel: 5
        level: 3
    ]
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