var extend = require('util')._extend,
    Logger = require('nightwatch/lib/util/logger.js'),<

    domable = {
        selector: function (children) {
            return 'linque-dot:nth-last-child(' + this.position + ') ' + (children || '');
        }
    },

    dotable = {
        upgrade: function () {

            var dot = null, i = this.length;

            while (i--) {
                extend(this[i], domable);
            }
        },
        findByType: function (type) {
            var dot = null, i = this.length;

            while (i--) {
                if (this[i].type === type) {
                    dot = this[i];
                    break;
                }
            }

            return dot;
        },
        findByPosition: function (position) {
            var dot = null, i = this.length;

            while (i--) {
                if (this[i].position === position) {
                    dot = this[i];
                    break;
                }
            }

            return dot;
        }
    },
    dots = {
        ask: function () {
            return Dots.find().fetch();
        },
        asked: function (result) {
            var model;

            if (!result.value) {
                console.log(Logger.colors.yellow("!  ") + "Dots: Could not get dots from meteor client, will retry forever.");

                dots.retry = true;
                dots.get.call(this, dots.callback);
            } else {
                dots.retry && console.log(Logger.colors.green("➜ "), "Dots: Retry successful. Got dots " + result.value.length + ".");

                model = extend(result.value, dotable);
                model.upgrade();

                this.globals.dots = model;

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