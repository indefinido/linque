var user = {
    ask: function () {
       return Meteor.user()
    },
    asked: function (result) {
        this.globals.user = result.value;
    }
};

// TODO figure out how to pipe callback
exports.command = function (callback) { return this.execute(user.ask, [], user.asked).pause(100, callback); };