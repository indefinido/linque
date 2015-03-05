exports.command = function (username, callback) {
    if (typeof username == 'function') {
        callback = username;
        username = null
    }
    return this.url("http://127.0.0.1:3000")
        .execute('Meteor.insecureUserLogin("' + (username || 'mafagafo-' + '" + Random.id() + "') + '")', [], callback)
        .pause(500)
        .user();
}
