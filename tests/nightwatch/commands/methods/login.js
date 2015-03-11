exports.command = function (username, callback) {
    if (typeof username == 'function') {
        callback = username;
        username = null
    }
    return this.execute('Meteor.insecureUserLogin("' + (username || 'mafagafo-' + '" + Random.id() + "') + '")', [], callback)
        .user();
}
