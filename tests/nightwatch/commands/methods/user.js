Logger = require('nightwatch/lib/util/logger.js')

var user = {
    ask: function () {
        return Meteor.user()
    },
    asked: function (result) {

        if (!result.value) {
            console.log(Logger.colors.yellow("!  ") + "User: Could not get user from meteor client, will retry forever.");
            user.retry = true;
            this.pause(100);
            user.get.call(this, user.callback);
        } else {
            user.retry && console.log(Logger.colors.green("➜ "), "User: Retry successful. Got user " + result.value.username + ".");
            this.globals.user = result.value;

            user.retry = user.callback = null;
        }
    },
    get: function (callback) {
        user.callback = callback;
        return this
            .pause(100)
            .execute(user.ask, [], user.asked)
            .pause(100, callback);
    }
};

// TODO figure out how to pipe callback
exports.command = user.get;