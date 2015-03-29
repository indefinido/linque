var Logger = require('nightwatch/lib/util/logger.js');

module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },
    "Simple message to warn about upcoming decision that shows up in a pre-defined dot in the path": function(client) {
        return client
            .walkUntilDot('warning', function (dot) {
                var dots = client.globals.dots, decision = dots.findByType('decision');

                client
                    .waitForElementVisible(dot.selector(' core-overlay')                  , 2000, 'Current dot overlay opened.')
                    .waitForElementPresent(decision.selector(' .core-animation-target')   , 2000, 'Next decision dot animated.')
                    .waitForElementVisible(dot.selector(' core-overlay [icon="decision:warning"]')     , 2000, 'Overlay of type warning detected.')

                    // To allow developer see the animation
                    .pause(1000)

                    .click(dot.selector(' core-overlay paper-button'))
                    .waitForElementNotVisible(dot.selector(' core-overlay')               , 2000, 'Current dot overlay closed.')
                    .waitForElementNotPresent(decision.selector(' .core-animation-target'), 2000, 'Next decision dot stoped animation.')
                    .end()
            });
    }
};