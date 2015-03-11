module.exports = {
  beforeEach: function () {
    return this.client
          .url("http://127.0.0.1:3000")
          .waitForSplash()
          .login()
  },

  "User can see his current habit points, picture, level and skills": function(client) {
    return client
          .assert.visible(".container .progress", "Habits point bar is visible.")
          .assert.visible(".container img.user-picture", "User picture is visible.")
          .assert.visible(".container .skills", "Skillset list is visible")
          .count(".container .skills > .skill", function (result) {
              this.assert.equal(result.value, 4, "There are 4 skills in the skill set")
          })
          .end();
  }
};
