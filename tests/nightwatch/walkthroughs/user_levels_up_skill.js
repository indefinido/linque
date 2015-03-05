module.exports = {
    "User sees feedback of leveling up": function(client) {
        return client
            .login()
            .pause(500)
            // As of now, skill level changes with user level
            .assert.containsText('body', '1')
            .assert.containsText('#drink.skill', '(POUCO)')
            .click("#drink.skill paper-button")
            .pause(200)
            .click("#drink.skill paper-button")
            .pause(200)
            .click("#drink.skill paper-button")
            .pause(200)
            .click("#drink.skill paper-button")
            .pause(200)
            .click("#drink.skill paper-button")
            .pause(200)
            .assert.containsText('body', 'Level: 3')
            .assert.containsText('#drink.skill', '(MÉDIO)')
            .end();
    }
};
