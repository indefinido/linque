module.exports = {
    beforeEach: function () {
        return this.client
            .url("http://127.0.0.1:3000")
            .waitForSplash()
            .login()
    },

    "Current rule level summary": function(client) {
        var hoverable = 'rule-item#container /deep/ #question-mark',
            summaryHolder = 'rule-item#container div[tip]'


        return client
            .moveToElement(hoverable, 1, 1)
            .waitForElementVisible(summaryHolder, 1000, "Tooltip appeared")
            // Rule level summary
            .assert.containsText(summaryHolder, "Você pode ter apenas um Copo de volume de 250 ml", "Current rule level summary was visible.")

            // TODO Test next level rule summary
            .end();
    }
};
