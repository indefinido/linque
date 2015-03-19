module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },

    "Hover on a Rule shows up a tooltip with basic info": function(client) {
        return client
            .moveToElement('#fill.rule', 15, 15)
            .waitForElementVisible("#fill.rule div[tip]", 1000)
            // Rule level summary
            .assert.containsText("#fill.rule div[tip]", "ENCHER RECIPIENTE", "Rule Name")
            .assert.containsText("#fill.rule div[tip]", "Adquirido no nível 1", "Rule Required Level")
            // When next level will be obtained
            .assert.containsText("#fill.rule div[tip]", "Adquirido no nível 1", "Current Rule Required Level")
            .assert.containsText("#fill.rule div[tip]", "Requer nível 5", "Last Rule Required Level")
            .assert.containsText("#fill.rule div[tip]", "Requer nível 3", "Next Rule Required Level")
            .end();
    }
};
