var i = 0;

exports.command = function (username, callback) {
    if (typeof username == 'function') {
        callback = username;
        username = null
    }
    return this.url("http://127.0.0.1:3000")
        .execute('Meteor.insecureUserLogin("' + (username || 'mafagafo' + i++) + '")', [], callback)
        .user();
}
