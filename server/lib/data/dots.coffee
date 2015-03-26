@records ||= {}

@records.Dots = [
    # _id == Dot position
    _id: 1
    type: 'event'
    body: 'Sua jornada começa aqui'
  ,
    _id: 3
    type: 'tip'
    title: 'Por que um copo e não uma garrafa?'
    body: 'Não se preocupe, você não vai ficar com o copo para sempre. É questão de 2 ou 3 dias. Você está usando ele pra poder começar rápido a desenvolver seu hábito. Principalmente porque é fácil conseguir um copo.'
  ,
    _id: 5
    type: 'tip'
    title: 'Não vá com muita sede ao pote!'
    body: 'Lembre-se, a quantidade de água não é importante agora. Tente fazer a água do seu copo durar o dia todo. Isso evita que você tenha que enchê-lo mais de uma vez. (O esforço de encher o copo pode ser pouco, mas certamente pode atrapalhar o seu hábito.)'
  ,
    _id: 7
    type: 'tip'
    title: 'Ainda não se convenceu?'
    body: 'O Linque existe justamente porque vimos várias pessoas tentarem criar o mesmo hábito que você está tentando, de beber bastante água, e foram com muita sede ao pote. Já começaram colocando ao lado uma garrafa de 1,5 L. Adivinha quanto tempo durou? 1 semana. É. Melhor você ir devagarinho. Seguindo o que o Linque sugere, você vai caminhar na velocidade certa ;)'
  ,
    _id: 9
    type: 'warning'
    title: 'Uma mudança se aproxima!'
    body: 'Você prefere adquirir um recipiente maior ou poder encher seu recipiente mais vezes por dia?\n\nPense agora e esteja preparado para quando chegar a hora de escolher.'
  ,
    _id: 20
    type: 'event'
    title: 'Você encontrou um copo quebrado'
    body: 'Outros usuários que já passaram por aqui estão jogando fora seus copos e trocando por garrafas. A maioria prefere assim, já que evita ter que encher o copo muitas vezes para tomar mais água. Lembre-se disso quando chegar a hora de decidir.'
  ,
    _id: 22
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 30
    type: 'tip'
    title: 'Está se sentindo no deserto?'
    body: 'Se estiver com sede, não tem problema beber mais água. No entanto, tente não usar a água do seu copo para matar a sede, apenas para responder aos seus gatilhos.'
  ,
    _id: 40
    type: 'tip'
    title: 'Comece o dia bem.'
    body: 'Ao final do dia, deixe seu recipiente sempre no lugar que você bebe água. Assim você tem uma barreira a menos para começar a tomar água no dia seguinte.'
  ,
    _id: 50
    type: 'tip'
    title: 'Foco! Foco! Foco!'
    body: 'Foque apenas no ambiente em que você passa a maior parte do tempo (seu quarto, trabalho, etc). Depois que tiver o hábito desenvolvido, você naturalmente procurará criar o hábito em outros ambientes. Se tiver pressa, não conseguirá criá-lo em lugar nenhum.'
  ,
    _id: 60
    type: 'tip'
    title: 'Sua garrafa é sagrada.'
    body: 'Não leve sua garrafa de casa para o trabalho ou do trabalho para casa. Isso dificulta manter seu hábito. A menos é claro, que você tenha um Vessyl (https://www.myvessyl.com). Ele deve te dar motivação suficiente pra levar para todo lado e encher quantas vezes for preciso!'
  ,
    _id: 64
    type: 'warning'
    title: 'Uma mudança se aproxima!'
    body: 'Você prefere adquirir um recipiente maior ou poder encher seu recipiente mais vezes por dia?\n\nPense agora e esteja preparado para quando chegar a hora de escolher.'
  ,
    _id: 77
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 156
    type: 'warning'
    title: 'Uma mudança se aproxima!'
    body: 'Você prefere adquirir um recipiente maior ou poder encher seu recipiente mais vezes por dia?\n\nPense agora e esteja preparado para quando chegar a hora de escolher.'
  ,
    _id: 176
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 180
    type: 'tip'
    title: 'Mantenha-se no caminho.'
    body: 'Não abandone o seu caminho quando estiver bebendo a quantidade de água que você precisa. Sem completá-lo você não consegue criar o hábito e, cedo ou tarde, o pouquinho que você desenvolveu dele vai sumir.'
  ,
    _id: 310
    type: 'warning'
    title: 'Uma mudança se aproxima!'
    body: 'Você prefere adquirir um recipiente maior ou poder encher seu recipiente mais vezes por dia?\n\nPense agora e esteja preparado para quando chegar a hora de escolher.'
  ,
    _id: 330
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 407
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 484
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 572
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 660
    type: 'decision'
    body: 'O que você prefere? (1) Trocar seu recipiente por outro maior; ou (2) Poder encher seu recipiente atual mais vezes.'
  ,
    _id: 661
    type: 'final'
    body: 'Sua jornada termina aqui'

  # ,
  #   _id: 0
  #   type: 'tip'
  #   title: 'Você ja é uma mina de água?'
  #   body: ' Já está bebendo a quantidade que gostaria por dia? Não precisa beber mais do que isso. No entanto, escolher uma opção vai permitir você ficar mais livre para escolher o recipiente que quiser e enchê-lo quantas vezes precisar.'
  # ,
  #   _id: 0
  #   type: 'tip'
  #   title: 'O que fazer em dias quentes.'
  #   body: 'Quando estiver muito calor, provavelmente você vai tomar água quente, se usar uma garrafa grande. Se isso for um problema para você, use uma garrafa menor. Desde que seu hábito já esteja formado, isso não vai te atrapalhar.'

]
