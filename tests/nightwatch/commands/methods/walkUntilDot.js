exports.command = function (locator, callback /* , position */) {
    var client = this;
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

        i = target.position;

        while (--i) {
            client.click('track-button', function () {
                positionated = dots.findByPosition(j++);
                if (positionated) {
                  switch (positionated.type) {
                    case 'decision':
                      client.pause(500).execute('$("' + positionated.selector(' core-overlay:visible paper-button:not([disabled]):first') + '").click()')
                      break;
                    default:
                      client.click(positionated.selector(' core-overlay paper-button:not([disabled])'));
                      break;
                  }
                }

                client.moveTo('.user');
            });
        }

        client.click('track-button');

        callback && callback(target);
    });
};