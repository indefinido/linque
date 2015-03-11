exports.command = function () {
    return this
        .waitForElementVisible(   '.pg-loading-screen', 2000, "Splash screen displayed.")
        .waitForElementNotVisible('.pg-loading-screen', 2000, "Splash screen hidden."   )
}
