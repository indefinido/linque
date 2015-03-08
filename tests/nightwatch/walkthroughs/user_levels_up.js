module.exports = {
    "When leveling up": function (client) {
        experience = null;
        return client
            .login()
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
