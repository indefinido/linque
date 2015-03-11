module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
    },

    "User can see skills": function(client) {
        return client
            .login()
            .pause(500)
            .assert.visible('.skills')
            .end()
     },
    "An activity will be created": function(client) {
        var activities = null;

        return client
            .login()
            .pause(500)
            .count('.activity' , function (result) { activities = result.value; })
            .pause(500)
            .click('#fill.skill skill-button')
            .pause(500)
            .count('.activity' , function (result) {
                this.assert.equal(activities + 1, result.value, "A new activity was displayed.")
            })
            .end()
    },
    "User earns experience": function (client) {
        var experience = null;

        return client
            .login(function () {
                experience = this.globals.user.experience;
            })
            // Figure out why splash screen is getting loaded twice
            .pause(500)
            .click('#fill.skill skill-button')
            .user(function () {
                var currentExperience = this.globals.user.experience;
                this.assert.notEqual(currentExperience, experience, 'User experience has changed by ' + (currentExperience - experience) + '.');
            })
            .end()
    },

    "User skill will be blocked by cooldown": function (client) {
        console.log("Pending: Implement skill cooldown");
        client.end();
    }
};
