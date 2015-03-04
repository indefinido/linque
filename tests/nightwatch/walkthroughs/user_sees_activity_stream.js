module.exports = {
  "User can see activity stream": function(client) {
      return client
          .login()
          .assert.visible('#activities')
          .end()

  },
  "User can see skill usage activity": function (client) {
      return client
          .login()
          .click('#drink.skill')
          .assert.containsText('#activities', 'Beber Água')
          .end()
  }
};
