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
    "User sees feedback of leveling up Rule": function(client) {

        client
            .walkUntilDot('decision', function (dot) {
                var currentDot = dot.selector();

                client
                    // Close dialog by selecting the first rule to level up
                    .execute('$("' + dot.selector(' core-overlay paper-button:not([disabled]):first') + '").click()')

                    .waitForElementPresent(   '.tool.rules /deep/ .core-animation-target', 4000, 'User rule animation started')
                    .waitForElementNotPresent('.tool.rules /deep/ .core-animation-target', 2000, 'User rule animation finished')
                    .end();
            });
    },
    "User sees feedback of taken Decision": function(client) {
        client
            .walkUntilDot('decision', function (dot) {

                client
                    .pause(500)
                    // Close dialog by selecting the first rule to level up
                    .execute('$("' + dot.selector(' core-overlay:visible paper-button:not([disabled]):first') + '").click()')
                    // Walk one more dot after taken decision
                    // TODO remove when user walks automatically
                    .click('track-button')

                    .waitForElementPresent(dot.selector(' [icon="decision:decided"]'), 2000, 'Decision icon is marked as completed')
                    .end();
            });
    },
    "User is prompted to make a decision in a pre-defined dot in the path": function(client) {
        return client
            .walkUntilDot('decision', function (dot) {

                client
                    .waitForElementVisible(dot.selector(' core-overlay'              ), 2000, 'Current dot overlay opened.')
                    .waitForElementVisible(dot.selector(' core-overlay [icon="decision:decision"]'), 2000, 'Overlay of type Decision detected.')
                    .waitForElementPresent(dot.selector(' .core-animation-target'    ), 2000, 'User avatar animation started')

                    .pause(1500)

                    .execute('$("' + dot.selector(' core-overlay:visible paper-button:not([disabled]):first') + '").click()')

                    .waitForElementNotPresent(dot.selector(' .core-animation-target'), 2000, 'User avatar animation stoped')
                    .waitForElementNotVisible(dot.selector(' core-overlay'          ), 2000, 'Current dot overlay closed.')
                    .walkUntilDot(407, function (dot) {

                        client
                            .waitForElementVisible(dot.selector(' core-overlay'              ), 2000, 'Current dot overlay opened.')

                            .count(dot.selector(' core-overlay paper-button'), 3, 'Max rule level is not visible.');
                    });
            })
    }
};
