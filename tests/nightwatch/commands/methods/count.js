// TODO figure out how to count in nightwacher
exports.command = function (selector, callback) {
    return this.execute('return $("' + selector + '").length;', [], callback);
};