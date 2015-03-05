exports.command = function (expected) {
    return this.assert.containsText('.user .user-level-value', expected, "User level is " + expected)
}
