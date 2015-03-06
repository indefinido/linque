module.exports = {
    "User sees feedback of leveling up": function(client) {
        var levelUpDialog      = "core-overlay-layer ::shadow .dialog.dialog-levelup",
            skillLevelUpDialog = "core-overlay-layer ::shadow .dialog.dialog-skill-levelup";
        return client
            .login()
            .level(1)
            .click("#fill.skill")
            
            .waitForElementVisible(levelUpDialog, 3000)
            .click(levelUpDialog + " paper-button")
            
            .waitForElementVisible(skillLevelUpDialog, 5000)
            .assert.containsText(skillLevelUpDialog, 'Possuir um Recipiente')
            .click(skillLevelUpDialog + " paper-button")
            .waitForElementNotVisible(skillLevelUpDialog, 5000)
            
            .waitForElementVisible(   skillLevelUpDialog, 5000)
            .assert.containsText(skillLevelUpDialog, 'Receber Gatilho')
            .end();
    }
};
