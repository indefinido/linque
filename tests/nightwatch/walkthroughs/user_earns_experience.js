module.exports = {
  "User sees feedback in context": function(client) {
      var progress;
      
      var levelUpDialog      = "core-overlay-layer ::shadow .dialog.dialog-levelup",
          skillLevelUpDialog = "core-overlay-layer ::shadow .dialog.dialog-skill-levelup";
      

      return this.client
          .login()
          .pause(200)
          
          // current bar experience
          .getAttribute("paper-progress", 'value', function (result) {
              progress = result.value;
          })
          
          // use fill skill
          .click("#fill.skill paper-button")
          .waitForElementVisible('#earned-experience', 1000, "Experience toast was displayed.")
          
          // closing dialogs
          .waitForElementVisible(levelUpDialog, 3000)
          .click(levelUpDialog + " paper-button")
          //
          .waitForElementVisible(skillLevelUpDialog, 5000)
          .assert.containsText(skillLevelUpDialog, 'Receber Gatilho')
          .click(skillLevelUpDialog + " paper-button")
          .waitForElementNotVisible(skillLevelUpDialog, 5000)
          //
          .waitForElementVisible(skillLevelUpDialog, 5000)
          .assert.containsText(skillLevelUpDialog, 'Beber Água')
          .click(skillLevelUpDialog + " paper-button")
          .waitForElementNotVisible(skillLevelUpDialog, 5000)
          // end closing dialogs
          
          // use drink skill
          .click("#drink.skill paper-button")
            
          // test if experience bar has changed
          .getAttribute("paper-progress", 'value', function (result) {
              this.assert.notEqual(progress, result.value, "Progress bar have changed.")
          })

          .end();
  }
};
