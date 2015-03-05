module.exports = {
    "User sees feedback of leveling up": function(client) {
        return client
            .login()
            // As of now, skill level changes with user level
            .level(2)
            .moveToElement('#drink.skill')
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
            .level(3)
            .assert.containsText('#drink.skill', '(MÉDIO)')
            .end();
    }
};
