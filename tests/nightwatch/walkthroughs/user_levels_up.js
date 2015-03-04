module.exports = {
    "Level up associated skills": function(client) {
        console.log("Pending")
        return client.end();
    },
    "When leveling up": function (client) {
        return client
            .login()
            .pause(500)
            .assert.containsText('body', 'Level: 1')
            .click("#fill.skill paper-button")
            .assert.containsText('body', 'Level: 2')
            .getAttribute("paper-progress", 'value', function (result) {
                this.assert.equal(result.value, 0, "Progress bar is at zero.");
            })
            .end();
    }
};
