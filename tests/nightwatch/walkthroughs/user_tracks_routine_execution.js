module.exports = {
    beforeEach: function () {
        return this.client.url("http://127.0.0.1:3000")
            .login()
            .waitForSplash()
    },

    "User walks on pathway": function(client) {
        return client
            .moveToElement('.user', 15, 15)
            .assert.elementPresent('linque-dot:last-child .user', 'User avatar inside first point.')
            .click('linque-dot:last-child core-overlay paper-button:not([disabled])') // Close dialog
            .pause(200)
            .click('track-button')
            .waitForElementPresent('linque-dot:nth-last-child(2) .user', 2000, 'User avatar moved to second point.')
            .end()
    },

    "User sees feedback of tracking": function(client) {
        return client
            .moveToElement('.user', 15, 15)
            .assert.elementPresent('linque-dot:last-child .user', 'User on first dot.')
            .click('linque-dot:last-child core-overlay paper-button:not([disabled])') // Close dialog
            .pause(200)
            .click('track-button')

            .waitForElementPresent('linque-dot.completed:last-child', 2000, 'First completed dot created.')

            .url("http://127.0.0.1:3000")
            .waitForSplash()

            .waitForElementPresent('linque-dot.completed:last-child', 2000, 'First completed dot persisted.')
            .end()
    }
};
