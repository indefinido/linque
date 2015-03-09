module.exports = {
    "User sees feedback of leveling up": function(client) {
        var levelUpDialog      = "core-overlay-layer ::shadow .dialog.dialog-levelup",
            skillLevelUpDialog = "core-overlay-layer ::shadow .dialog.dialog-skill-levelup";

        return client
            .login()
            .level(1)
            .click("#fill.skill")

            .waitForElementVisible(levelUpDialog, 3000, "Level up dialog was visible.")
            .click(levelUpDialog + " paper-button")

            .waitForElementVisible(skillLevelUpDialog, 5000, "Skill level up dialog was visible.")
            .assert.containsText(skillLevelUpDialog, 'RECEBER GATILHO', "Dialog contains 'RECEBER GATILHO' ")
            .click(skillLevelUpDialog + " paper-button")
            .waitForElementNotVisible(skillLevelUpDialog, 5000, "Skill level up dialog was closed.")

            .waitForElementVisible(skillLevelUpDialog, 5000, "Second skill level up dialog was displayed.")
            .assert.containsText(skillLevelUpDialog, 'BEBER ÁGUA', "Dialog contains 'BEBER ÁGUA'")
            .end();
    }
};
