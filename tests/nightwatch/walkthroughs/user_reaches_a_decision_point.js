module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },
    "User sees feedback of leveling up": function(client) {
        var levelUpDialog      = "core-overlay-layer ::shadow .dialog.dialog-levelup",
            ruleLevelUpDialog = "core-overlay-layer ::shadow .dialog.dialog-rule-levelup";

        return client
            .level(1)
            .click("#fill.rule")

            .waitForElementVisible(levelUpDialog, 3000, "Level up dialog was visible.")
            .click(levelUpDialog + " paper-button")

            .waitForElementVisible(ruleLevelUpDialog, 5000, "Skill level up dialog was visible.")
            .assert.containsText(ruleLevelUpDialog, 'RECEBER GATILHO', "Dialog contains 'RECEBER GATILHO' ")
            .click(ruleLevelUpDialog + " paper-button")
            .waitForElementNotVisible(ruleLevelUpDialog, 5000, "Skill level up dialog was closed.")

            .waitForElementVisible(ruleLevelUpDialog, 5000, "Second rule level up dialog was displayed.")
            .assert.containsText(ruleLevelUpDialog, 'BEBER ÁGUA', "Dialog contains 'BEBER ÁGUA'")
            .end();
    }
};
