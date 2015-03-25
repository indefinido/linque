module.exports = {
    beforeEach: function () {
        return this.client.url("http://127.0.0.1:3000")
            .login()
            .waitForSplash()
    },

    "User walks on pathway": function(client) {
        return client
            .assert.elementPresent('linque-dot:last-child .user', 'User avatar inside first point.')
            .moveTo('.user')
            .click('track-button')
            .waitForElementPresent('linque-dot:nth-last-child(2) .user', 2000, 'User avatar moved to second point.')
            .end()
    },

    "User sees feedback of tracking": function(client) {
        return client
            .assert.elementPresent('linque-dot:last-child .user', 'User on first dot.')
            .moveTo('.user')
            .click('track-button')

            .waitForElementPresent('linque-dot[completed]:nth-last-child(1)', 2000, 'First completed dot created.')

            .url("http://127.0.0.1:3000")
            .waitForSplash()

            .waitForElementPresent('linque-dot[completed]:nth-last-child(1)', 2000, 'First completed dot persisted.')
            .end()
    }
};
