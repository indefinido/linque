describe("User sees feedback in context", function() {
    var server = meteor();
    var client = browser(server);

    it("User sees feedback in context", function () {
        var progress;

        return client
            .login()
            .pause(200)
            .getAttribute("paper-progress", 'value', function (result) {
                progress = result.value;
            })
            .click("#fill.skill paper-button")
            .waitForElementVisible('#earned-experience', 1000, "Experience toast was displayed.")
            .getAttribute("paper-progress", 'value', function (result) {
                this.assert.notEqual(progress, result.value, "Progress bar have changed.")
            })
            .end();
    });
});
