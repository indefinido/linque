module.exports = {
  "User can see his current experience, level and skills": function(client) {
    return client
          .login()
          .assert.containsText("body"   , "Experience")
          .assert.containsText("body"   , "Level:")
          .assert.containsText(".skills", "RECEBER")
          .end();
  }
};
