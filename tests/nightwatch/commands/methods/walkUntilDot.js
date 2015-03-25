exports.command = function (type, callback /* , position */) {
    var client = this;
    return this.dots(function () {
        var i = undefined, j = 1, typed = undefined, positionated = undefined,
            dots = client.globals.dots;

        typed = dots.findByType(type);

        i = typed.position;

        while (--i) {
            client.click('track-button', function () {
                positionated = dots.findByPosition(j++);
                if (positionated)
                  switch (positionated.type) {
                    case 'decision':
                      client.pause(500).execute('$("' + positionated.selector('core-overlay:visible paper-button:not([disabled]):first') + '").click()')
                      break;
                    default:
                      client.click(positionated.selector('core-overlay paper-button:not([disabled])'));
                      break;
                  }
            });
        }

        client.click('track-button');

        callback && callback(typed);
    });
};