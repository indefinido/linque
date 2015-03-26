module.exports = {
    beforeEach: function () {
        return this.client.url("http://127.0.0.1:3000")
            .login()
            .waitForSplash()
    },

    "A message to motivate or guide decisions that shows up in a pre-defined Dot in the path": function(client) {

        return client
            .walkUntilDot('event', function (dot) {
                client
                    .waitForElementVisible(dot.selector(' core-overlay')       , 2000, 'Current dot overlay opened.')
                    .waitForElementVisible(dot.selector(' [icon="dot:event"]') , 2000, 'Overlay of type Event detected.')
                    .click(dot.selector(' core-overlay paper-button'))
                    .waitForElementNotVisible(dot.selector(' core-overlay')    , 2000, 'Current dot overlay closed.')
                    .end()
            })

    }
};
