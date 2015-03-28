var Logger = require('nightwatch/lib/util/logger.js'), client, dots,
    walker = {
        position: 1,
        walk: function (amount, callback) {
            this.position = client.globals.user.position;
            this.amount   = amount;
            this.callback = callback;
            this.step();
        },
        step: function () {
            if (walker.amount % 5 == 0) client.moveToElement('.user', 15, 15)

            if (walker.amount) {
                walker.closeDialog();
                client.click('track-button');
                monitorer.waitForPositionChange(walker.steped);
            } else {
                walker.arrive();
            }

        },
        steped: function (position) {
            if (position != walker.position) {
                walker.amount--;
                walker.position++;
            }

            walker.step();
        },
        closeDialog: function () {
            var positionated = dots.findByPosition(walker.position);
            switch (positionated.type) {
            case 'decision':
                client.pause(500).execute('$("' + positionated.selector(' core-overlay:visible paper-button:not([disabled]):first') + '").click()');
                break;
            case 'empty':
                break;
            default:
                client.click(positionated.selector(' core-overlay paper-button:not([disabled])'));
                break;
            }
        },
        arrive: function() {
            this.callback && this.callback.call(client, dots.findByPosition(walker.position));
        }
    }, monitorer = {
        currentPosition: null,
        retries: 10,
        waitForPositionChange: function (callback) {
            var user = client.globals.user;
            this.retries = 10;
            this.currentPosition = user.position;
            this.callback = callback;
            client.user(this.check);
        },
        check: function () {
            var user = client.globals.user;

            if (monitorer.retries-- == 0) {
                console.log(Logger.colors.yellow('!  '), 'Walker: Max retries for position: ', user.position, '. (walkUntilDot.monitorer.check)');
                console.log(Logger.colors.green( '➜  '), 'Walker: Will retry movement.');
                return monitorer.callback.call(this, user.position, {status: 'error'});
            }

            if (monitorer.currentPosition == user.position) {
                client
                    .pause(100)
                    .user(monitorer.check);
            } else {
                monitorer.callback.call(this, user.position);
            }
        }
    };


exports.command = function (locator, callback) {
    client = this;
    return this.user().dots(function () {
        var target = undefined, user, amount = 0;
        dots = client.globals.dots;
        user = client.globals.user;

        switch (typeof locator) {
        case 'string':
            target = dots.findByType(locator);
            break;
        case 'number':
            target = dots.findByPosition(locator);
            break;
        default:
            throw "Invalid dot locator type: " + typeof locator;
        }

        if (!target)
            throw new TypeError("Target not found for locator: " + locator + '.');

        if (!user || !user.position)
            console.log("Target not found for user: " + user + '.');

        amount = target.position - user.position;
        if (amount <= 0) {
            console.log(Logger.colors.red('✕ '), 'Walker: Can\'t move user by amount', amount + '.')
            console.log(Logger.colors.red('✕ '), 'Walker: From user position', user.position, 'walking to', target.position + '.');
            return false;
        }

        client.moveToElement('.user', 15, 15);

        walker.walk(amount, function () {return callback.call(this, target);});
    });
};