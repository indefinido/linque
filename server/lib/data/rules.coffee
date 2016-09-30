@records ||= {}

@records.Rules = [
    _id: 'container'
    levels: [
        qualifier: "250 ml"
        summary: "You can have only one Cup of 250ml volume."
        number: 1
      ,
        qualifier: "500 ml"
        summary: "You can have only one Bottle of volume until 500ml."
        number: 2
      ,
        qualifier: "1 L"
        summary: "You can have only one Bottle of volume until 1 L."
        number: 3
      ,
        qualifier: "1,5 L"
        summary: "You can have only one Bottle of volume until 1,5 L."
        number: 4
      ,
        qualifier: "Free"
        summary: "You can use whichever recipient you want when you feel."
        number: 5
    ]
  ,
    _id: 'fill'
    levels: [
        qualifier: "1x / day"
        summary: "You can fill your recipient only 1 time a day."
        number: 1
      ,
        qualifier: "2x / day"
        summary: "You can fill your recipient until 2 times a day."
        number: 2
      ,
        qualifier: "3x / day"
        summary: "You can fill your recipient until 3 times a day."
        number: 3
      ,
        qualifier: "4x / day"
        summary: "You can fill your recipient until 4 times a day."
        number: 4
      ,
        qualifier: "Free"
        summary: "You can fill your recipient as many times as you wish (be carefull to not drink to much water!)."
        number: 5
    ]
]
# pt-BR
# @records.Rules = [
#     _id: 'container'
#     levels: [
#         qualifier: "250 ml"
#         summary: "Você pode ter apenas um Copo de volume de 250 ml"
#         number: 1
#       ,
#         qualifier: "500 ml"
#         summary: "Você pode ter apenas uma Garrafa de volume de até 500 ml"
#         number: 2
#       ,
#         qualifier: "1 L"
#         summary: "Você pode ter apenas uma Garrafa de volume de até 1 L"
#         number: 3
#       ,
#         qualifier: "1,5 L"
#         summary: "Você pode ter apenas uma Garrafa de volume até 1,5 L"
#         number: 4
#       ,
#         qualifier: "Livre"
#         summary: "Você pode usar o recipiente que quiser quando achar melhor."
#         number: 5
#     ]
#   ,
#     _id: 'fill'
#     levels: [
#         qualifier: "1x / dia"
#         summary: "Você pode encher seu recipiente atual apenas 1 vez por dia."
#         number: 1
#       ,
#         qualifier: "2x / dia"
#         summary: "Você pode encher seu recipiente atual até 2 vezes por dia."
#         number: 2
#       ,
#         qualifier: "3x / dia"
#         summary: "Você pode encher seu recipiente atual até 3 vezes por dia."
#         number: 3
#       ,
#         qualifier: "4x / dia"
#         summary: "Você pode encher seu recipiente atual até 4 vezes por dia."
#         number: 4
#       ,
#         qualifier: "Livre"
#         summary: "Você pode encher seu recipiente quantas vezes quiser no mesmo dia (cuidado para não tomar água em excesso!)."
#         number: 5
#     ]
# ]
