module.exports = {
  "Hovering a skill shows up basic info": function(client) {
     return client
           .login()
           .moveToElement('#fill.skill', 5, 5)
           .waitForElementVisible("#fill.skill div[tip]", 1000)
           .assert.containsText("#fill.skill div", "Você pode encher seu recipiente")
           .end();
  }
};
