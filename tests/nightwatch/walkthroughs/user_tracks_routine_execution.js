module.exports = {
    beforeEach: function () {
        return this.client.url("http://127.0.0.1:3000")
            .login()
            .waitForSplash()
    },

    "User walks on pathway": function(client) {
        return client
            .assert.elementPresent('linque-dot:last-child .user')
            .moveTo('.user')
            .click('track-button')
            .assert.elementPresent('linque-dot:nth-last-child(2) .user')
            .end()
    },

    "User sees feedback of tracking": function(client) {
        return client
            .assert.elementPresent('linque-dot:last-child .user')
            .moveTo('.user')
            .click('track-button')

        // Feedback is created
            .assert.elementPresent('linque-dot[completed]:last-child(1)')

        // Feedback is preserved
            .url("http://127.0.0.1:3000")
            .assert.elementPresent('linque-dot[completed]:last-child(1)')
            .end()
    }
};
