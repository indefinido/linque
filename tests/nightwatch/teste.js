var acceptance;

acceptance = {

  beforeEach: function(client) {
    console.log("Setting up...");
  },

  "User can sign in": function(client) {
    return client.url("http://127.0.0.1:3000")
      .waitForElementVisible("body", 1000)
      .waitForElementVisible(".skills", 60000)
      .assert
      .containsText("body","Experience")
      .end();
  }

};

module.exports = acceptance;
