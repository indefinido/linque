module.exports = {
  "User can see his current habit points, picture, level and skills": function(client) {
    return client
          .login()
          .assert.visible(".container .progress", "Habits point bar is visible.")
          .assert.visible(".container img.user-picture", "User picture is visible.")
          .assert.visible(".container .skills", "Skillset list is visible")
          .count(".container .skills > .skill", function (result) {
              this.assert.equal(result.value, 4, "There are 4 skills in the skill set")
          })
          .end();
  }
};
