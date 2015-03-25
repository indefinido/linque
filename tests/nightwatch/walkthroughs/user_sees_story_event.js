module.exports = {
    beforeEach: function () {
        return this.client.url("http://127.0.0.1:3000")
            .login()
            .waitForSplash()
    },

    "A message to motivate or guide decisions that shows up in a pre-defined Dot in the path": function(client) {

        return client
            .walkUntilDot('storyEvent', function (dot) {
                var currentDot = dot.selector();

                client
                    .waitForElementVisible(currentDot + 'core-overlay'            , 2000, 'Current dot overlay opened.')
                    .waitForElementVisible(currentDot + '[icon="dot:storyEvent"]' , 2000, 'Overlay of type Story Event detected.')
                    .click(currentDot + 'core-overlay paper-button')
                    .waitForElementNotVisible(currentDot + 'core-overlay'         , 2000, 'Current dot overlay closed.')
                    .end()
            })

    }
};
