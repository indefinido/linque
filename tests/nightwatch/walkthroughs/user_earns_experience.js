module.exports = {
  before: function () {
    return this.client
          .url("http://127.0.0.1:3000")
          .waitForSplash()
          .login()
  },
  "User sees feedback in context": function(client) {
      var progress;

      var levelUpDialog      = "core-overlay-layer ::shadow .dialog.dialog-levelup",
          skillLevelUpDialog = "core-overlay-layer ::shadow .dialog.dialog-skill-levelup";

      return this.client
          // current bar experience
          .getAttribute("paper-progress", 'value', function (result) {
              progress = result.value;
          })

          // use fill skill
          .click("#fill.skill skill-button")
          .waitForElementVisible('#earned-experience', 1000, "Experience toast was displayed.")

          // closing dialogs
          .waitForElementVisible(levelUpDialog, 3000)
          .click(levelUpDialog + " paper-button")
          //
          .waitForElementVisible(skillLevelUpDialog, 5000)
          .assert.containsText(skillLevelUpDialog, 'RECEBER GATILHO')
          .click(skillLevelUpDialog + " paper-button")
          .waitForElementNotVisible(skillLevelUpDialog, 5000)
          //
          .waitForElementVisible(skillLevelUpDialog, 5000)
          .assert.containsText(skillLevelUpDialog, 'BEBER ÁGUA')
          .click(skillLevelUpDialog + " paper-button")
          .waitForElementNotVisible(skillLevelUpDialog, 5000)
          // end closing dialogs

          // use drink skill
          .click("#drink.skill skill-button")

          // test if experience bar has changed
          .getAttribute("paper-progress", 'value', function (result) {
              this.assert.notEqual(progress, result.value, "Progress bar have changed.")
          })

          .end();
  }
};
