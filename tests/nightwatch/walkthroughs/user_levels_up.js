module.exports = {

    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },

    "When leveling up": function (client) {
        var experience = null;

        return client
            .pause(500)

            .assert.containsText('body', "NÍVEL\n1")

            .getAttribute("paper-progress", 'value', function (result) {
                experience = result.value
            })
            .click("#fill.skill skill-button")

            .assert.containsText('body', "NÍVEL\n2")

            // TODO test progress bar going to the exact XP?
            .getAttribute("paper-progress", 'value', function (result) {
                this.assert.equal(result.value, 0, "Progress bar is at zero.");
            })

            .end();
    },

    "Level up associated skills": function(client) {
        console.log("Pending")
        return client.end();
    }
};
