var Logger = require('nightwatch/lib/util/logger.js')

var dots = {
    ask: function () {
        return Dots.find().fetch();
    },
    asked: function (result) {

        if (!result.value) {
            console.log(Logger.colors.yellow("!  ") + "Dots: Could not get dots from meteor client, will retry forever.");
            dots.retry = true;
            this.pause(100);
            dots.get.call(this, dots.callback);
        } else {
            dots.retry && console.log(Logger.colors.green("➜ "), "Dots: Retry successful. Got dots " + result.value.length + ".");
            this.globals.dots = result.value;

            dots.retry = dots.callback = null;
        }
    },
    get: function (callback) {
        dots.callback = callback;
        return this
            .pause(100)
            .execute(dots.ask, [], dots.asked)
            .pause(100, callback);
    }
};

// TODO figure out how to pipe callback
exports.command = dots.get;