var extend = require('util')._extend,
    Logger = require('nightwatch/lib/util/logger.js'),

    domable = {
        selector: function (children) {
            return 'linque-dot:nth-last-child(' + this.position + ')' + (children || '');
        }
    },

    dotable = {
        emptyDotable: {
            _id: null,
            type: 'empty',
            isEmpty: true,
            completed: false
        },
        upgrade: function () {
            var dot = null, i = this.length;

            while (i--) {
                extend(this[i], domable);
            }
        },
        findByType: function (type) {
            var dot = null, i = this.length;

            while (i--) {
                // Accept only the dot with the smallest position and a walkable dot
                if (this[i].type === type && this[i].position > 1) {

                    if (dot) {
                        if (this[i].position < dot.position) {
                            dot = this[i]
                        }
                    } else {
                        dot = this[i];
                    }
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


            if (!dot) {
                if (position > this[0].position && position <= this[this.length - 1].position) {
                    dot = extend(extend({_id: position, position: position}, this.emptyDotable), domable);
                } else {
                    console.error(Logger.colors.red("✖  "), 'Dots: Can\'t walk to dot. Its outside of path or it is already there', position);
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
            console.log(result);

            if (!result.value || !result.value.length) {
                console.log(Logger.colors.yellow("!  "), "Dots: Could not get dots from meteor client, will retry forever.");

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