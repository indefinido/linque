module.exports = {
    beforeEach: function () {
        return this.client.url("http://127.0.0.1:3000")
            .login()
            .waitForSplash()
    },

    "A message to help in the habit formation that shows up in a pre-defined Dot in the path": function(client) {

        return client
            .walkUntilDot('tip', function (dot) {
                var currentDot = 'linque-dot:nth-last-child(' + dot.position + ') ';

                client
                    .waitForElementVisible(currentDot + 'core-overlay'       , 2000   , 'Current dot overlay opened.')
                    .assert.containsText(currentDot + 'core-overlay h2 span' , 'Dica:', 'Overlay of type Tip detected.')
                    .click(currentDot + 'core-overlay paper-button')
                    .waitForElementNotVisible(currentDot + 'core-overlay'    , 2000   , 'Current dot overlay closed.')
                    .end()
            })

    }
};
