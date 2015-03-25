var extend = require('util')._extend,
    domable = {
        selector: function (children) {
            return this.selector = 'linque-dot:nth-last-child(' + this.position + ') ' + (children || '');
        }
    },
    dot = {
        dots: null,
        findByType: function (type) {
            var dot = null, i = this.dots.length;

            while (i--) {
                dot = extend(this.dots[i], domable);
                if (dot.type === type) break;
            }

            return dot;
        },
        findByPosition: function (position) {
            var dot = null, i = this.dots.length;

            while (i--) {
                dot = extend(this.dots[i], domable);
                if (dot.position === position) break;
            }

            return dot;
        }
    };

exports.command = function (type, callback /* , position */) {
    return this.dots(function () {
        var i = undefined, j = 0, typed = undefined, positionated = undefined;
        dot.dots = this.globals.dots;

        typed = dot.findByType(type);

        i = typed.position;
        while (--i) {
            this.click('track-button');
            positionated = dot.findByPosition(j++);
            if (positionated) {
                this.click(positionated.selector('core-overlay paper-button'));
            }
        }

        callback && callback(typed);
    });
};