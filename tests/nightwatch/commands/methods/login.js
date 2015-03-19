
var accreditation = {
  method: function (username) {
      return 'Meteor.insecureUserLogin("' + (username || 'mafagafo-' + '" + Random.id() + "') + '", ' + accreditation.callback.toString() + ')'
  },

  callback: function (response) {
    if (response && response.error) {
        alert("An error occurred while calling Meteor.insecureUserLogin(): \n" + response.toString() + "\n\n Pause the tests see browser console.");
        console.log(response);
        throw response;
    }
  }
}


exports.command = function (username, callback) {
    if (typeof username == 'function') {
        callback = username;
        username = null
    }

    return this.execute(accreditation.method(username), [], callback)
             .user();
}
