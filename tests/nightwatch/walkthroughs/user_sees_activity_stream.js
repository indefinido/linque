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
            .click('#fill.skill paper-button')
            .assert.containsText('.activities', 'fill')
            .end()
    },

    "User can see activities grouped by date": function (client) {
        // TODO test for another days grouping
        return client
            .login()
            .click('#fill.skill paper-button')
            .assert.containsText('.activities', 'HOJE')
            .end()
    }
};
