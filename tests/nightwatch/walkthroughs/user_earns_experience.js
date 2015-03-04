module.exports = {
  "User sees feedback in context": function(client) {
      var progress;

      return this.client
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
  }
};
