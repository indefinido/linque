// TODO figure out how to count in nightwacher
exports.command = function (selector, amount, callback, message) {
    if (typeof amount == "function") {
        callback = amount;
        amount   = null
    }

    if (typeof callback == "string") {
        message  = callback;
        callback = null
    }

    callback = callback || function (result) {
        this.assert.equal(result.value, amount, message || "There are " + amount + " elements for the selector " + selector + ".");
    }

    return this.execute('return $("' + selector + '").length;', [], callback);
};