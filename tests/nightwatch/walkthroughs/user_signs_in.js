module.exports = {
  "User can sign in": function(client) {
    return client
          .login()
          .assert.visible("img.user-picture")
          .end();
  }
};
