module.exports = {
    "User can see activity stream": function(client) {
        return client
            .login()
            .assert.visible('.activities')
            .end()

    },

    "User can see skill usage activity": function (client) {
        return client
            .login()
            .click('#fill.skill skill-button')
            .waitForElementPresent('.activities .activity', 5000)
            .assert.attributeEquals(".activities .activity core-icon", "icon", "water:fill_1")
            .end()
    },

    "User can see activities grouped by date": function (client) {
        // TODO test for another days grouping
        return client
            .login()
            .click('#fill.skill skill-button')
            .assert.containsText('.activities', 'HOJE')
            .end()
    }
};
