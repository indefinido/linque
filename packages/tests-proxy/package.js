Package.describe({
	name: "velocity:test-proxy",
	summary: "Dynamically created package to expose test files to mirrors",
	version: "0.0.4",
	debugOnly: true
});

Package.onUse(function (api) {
	api.use("coffeescript", ["client", "server"]);
	api.add_files("tests/.reports/nightwatch-acceptance/FIREFOX_33.1.1_MAC_itWorks.xml",["server","client"]);
	api.add_files("tests/.reports/nightwatch-acceptance/FIREFOX_33.1.1_MAC_teste.xml",["server","client"]);
	api.add_files("tests/.reports/nightwatch-acceptance/teste.xml",["server","client"]);
	api.add_files("tests/mocha/client/sampleClientTest.js",["client"]);
	api.add_files("tests/mocha/server/sampleServerTest.js",["server"]);
	api.add_files("tests/nightwatch/teste.js",["server","client"]);
});