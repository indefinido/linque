var client, dots,
    walker = {
        walk: function (amount, callback) {
            this.amount   = amount;
            this.callback = callback;
            this.steps();
        },
        steps: function () {
            if (walker.amount % 10 == 0) client.moveToElement('.user', 15, 15)
            if (walker.amount) {
                monitorer.waitForPositionChange(walker.steps);
                client.click('track-button', walker.closeDialog);
            } else {
                walker.amount--;
                walker.arrive();
            }

        },
        closeDialog: function () {
            var positionated = dots.findByPosition(j++);
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
        }
    }, monitorer = {
        currentPosition: null,
        waitForPositionChange: function (callback) {
            var user = client.globals.user;
            this.currentPosition = user.position;
            this.callback = callback;
            client.user(this.check);
        },
        check: function () {
            var user = client.globals.user;
            if (monitorer.currentPosition == user.position) {
                this.client
                    .pause(200)
                    .user(monitorer.check);
            } else {
                monitorer.callback.call(this, user.position);
            }
        }
    };


exports.command = function (locator, callback) {
    client = this;
    return this.dots(function () {
        var i = undefined, j = 1, target = undefined, positionated = undefined,
            dots = client.globals.dots;

        switch (typeof locator) {
        case 'string':
            target = dots.findByType(locator);
            break;
        case 'number':
            target = dots.findByPosition(locator);
            break;
        default:
            throw "Invalid dot locator type: " + typeof locator
        }

        client.moveToElement('.user', 15, 15)
        client.walk(target.position, function () {return callback.call(this, target);});
    });
};