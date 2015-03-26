var Logger = require('nightwatch/lib/util/logger.js');

module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },
    "User sees upcoming Decision in path": function(client) {
        return client
            .dots(function () {
                var dots = client.globals.dots, decision = dots.findByType('decision');

                client
                    .assert.visible(decision.selector(' .icon-decision'), 'Decision icon is displayed on path')
                    .end()
            });

    },
    "User is prompted to make a decision in a pre-defined dot in the path": function(client) {
        return client
            .walkUntilDot('decision', function (dot) {
                var currentDot = dot.selector();

                client
                    .waitForElementVisible(currentDot + ' core-overlay'               , 2000, 'Current dot overlay opened.')
                    .waitForElementVisible(currentDot + ' [icon="decision:decision"]' , 2000, 'Overlay of type Decision detected.')
                    .pause(500)
                    .execute('$("' + dot.selector(' core-overlay:visible paper-button:not([disabled]):first') + '").click()')
                    .waitForElementNotVisible(currentDot + ' core-overlay'            , 2000, 'Current dot overlay closed.')
                    .end()
            });
    },
    "User sees feedback of leveling up Rule": function(client) {
        console.log(Logger.colors.yellow('! Pending: Wainting for animations implementation.'));

        client.end();
        //return client
        //    .walkUntilDot('decision', function (dot) {
        //        var currentDot = dot.selector();

        //        client
        //            .end();
        //    });
    },
    "User sees feedback of taken Decision": function(client) {
        client
            .walkUntilDot('decision', function (dot) {
                var currentDot = dot.selector();

                client
                    // Walk one more dot after taken decision
                    // TODO remove when user walks automatically
                    .click('track-button')
                    .waitForElementPresent(dot.selector(' [icon="decision:decided"]'), 2000, 'Decision icon is marked as completed')
                    .end();
            });
    }
};
