module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },

    "User can see his rules": function(client) {
        return client
            .assert.visible(".bottom-left.rules", "Ruleset list is visible")
            .count(".bottom-left.rules > .rule", function (result) {
                this.assert.equal(result.value, 2, "There are 2 rules in the rule set")
            })
            .end();
    },
    "User can see his current progress and his profile picture in a pathway format.": function(client) {
        return client
            .assert.visible("linque-dot img.user-picture", "User picture is visible inside a dot.")
    }
};
