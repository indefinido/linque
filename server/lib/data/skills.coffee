@records ||= {}

@records.Skills = [
    _id: 'container'
    activity: 'passive'
    order: 2
    levels: [
        name: "Possuir um Copo Pequeno"
        summary: "Você pode ter apenas um Copo de volume entre 200 ml e 300 ml"
        description: ""
        requiredLevel: 1
        level: 1
      ,
        name: "Possuir uma Garrafa Pequena"
        summary: "Você pode ter apenas uma Garrafa de volume entre 500 ml e 600 ml"
        description: ""
        requiredLevel: 2
        level: 2
      ,
        name: "Possuir uma Garrafa Média"
        summary: "Você pode ter apenas uma Garrafa de volume entre 900 ml e 1100 ml (1,1 L)"
        description: ""
        requiredLevel: 3
        level: 3
      ,
        name: "Possuir uma Garrafa Grande"
        summary: "Você pode ter apenas uma Garrafa de volume entre 1,4 L e 1,6 L"
        description: ""
        requiredLevel: 4
        level: 4
    ]
  ,
    _id: 'trigger'
    activity: 'passive'
    order: 3
    levels: [
        name: "Receber Gatilho"
        summary: "Você sabe receber gatilhos do ambiente. Use a habilidade de Beber Água sempre que beber água imediatamente após receber um gatilho."
        description: ""
        requiredLevel: 2
        level: 1
    ]
  ,
    _id: 'fill'
    activity: 'active'
    order: 1
    levels: [
        name: "Encher Recipiente 1 vez por dia"
        summary: "Você pode encher seu recipiente atual apenas 1 vez por dia. Use esta habilidade para registrar todas as vezes que você encheu seu recipiente."
        description: ""
        experience: 100
        requiredLevel: 1
        level: 1
      ,
        name: "Encher Recipiente 2 vezes por dia"
        summary: "Você pode encher seu recipiente atual até 2 vez por dia. Use esta habilidade para registrar todas as vezes que você encheu seu recipiente."
        description: ""
        experience: 75
        requiredLevel: 2
        level: 2
      ,
        name: "Encher Recipiente quantas vezes quiser"
        summary: "Você pode encher seu recipiente quantas vezes quiser no mesmo dia (cuidado para não tomar água em excesso!). Use esta habilidade para registrar todas as vezes que você encheu seu recipiente."
        description: ""
        experience: 75
        requiredLevel: 3
        level: 3
    ]
  ,
    _id: 'drink'
    activity: 'active'
    order: 4
    levels: [
        name: "Beber Água (pouco)"
        summary: "Você pode beber pouca água. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 2
        level: 1
      ,
        name: "Beber Água (médio)"
        summary: "Você pode beber um pouco mais de água do que antes. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 3
        level: 2
      ,
        name: "Beber Água (mais)"
        summary: "Você pode beber mais água do que antes. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 4
        level: 3
      ,
        name: "Beber Água (livre)"
        summary: "Você pode beber quanta água quiser ao receber um gatilho. Use esta habilidade para registrar todas as vezes que você bebeu água após receber um gatilho."
        description: ""
        experience: 50
        requiredLevel: 5
        level: 4
    ]
]