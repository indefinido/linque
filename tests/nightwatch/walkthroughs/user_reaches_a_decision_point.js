module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },
    "User sees upcoming Decision dot in path": function(client) {
        return client
            .walkUntilDot('decision', function (dot) {
                var currentDot = dot.selector();

                client
                    .waitForElementVisible(currentDot + 'core-overlay'            , 2000, 'Current dot overlay opened.')
                    .waitForElementVisible(currentDot + '[icon="dot:decision"]'   , 2000, 'Overlay of type Decision detected.')
                    .click(currentDot + 'core-overlay paper-button')
                    .waitForElementNotVisible(currentDot + 'core-overlay'         , 2000, 'Current dot overlay closed.')
                    .end()
            });

    },
    "User is prompted to make a decision in a pre-defined Dot in the path": function(client) {
        return client
            .end();
    },
    "User sees feedback of leveling up Rule": function(client) {
        return client
            .end();
    }
};
