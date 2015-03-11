module.exports = {
  beforeEach: function () {
      return this.client.url("http://127.0.0.1:3000")
                 .waitForSplash()
  },
  "User can sign in": function(client) {
    return client
          .login()
          .assert.visible("img.user-picture")
          .end();
  }
};
