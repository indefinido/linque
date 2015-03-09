module.exports = {
  "Hovering a skill shows up current skill level info": function(client) {
      return client
          .login()
          .moveToElement('#fill.skill', 15, 15)
          .waitForElementVisible("#fill.skill div[tip]", 1000)
          .assert.containsText("#fill.skill div[tip]", "ENCHER RECIPIENTE", "Skill Name")
          .assert.containsText("#fill.skill div[tip]", "Você pode encher seu recipiente", "Skill Pontos de Hábito")
          .assert.containsText("#fill.skill div[tip]", "Adquirido no nível 1", "Skill Required Level")
          .end();
  },
  "Hovering a skill shows next skill levels": function (client) {
      return client
          .login()
          .moveToElement('#fill.skill', 15, 15)
          .waitForElementVisible("#fill.skill div[tip]", 1000)
          .assert.containsText(  "#fill.skill div[tip]", "Adquirido no nível 1", "Current Skill Required Level")
          .assert.containsText(  "#fill.skill div[tip]", "Requer nível 3", "Next Skill Required Level")
          .assert.containsText(  "#fill.skill div[tip]", "Requer nível 5", "Last Skill Required Level")
          .end();
  }
};
