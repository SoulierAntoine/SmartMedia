"use strict"

var yargs = require("yargs")

module.exports = function(app) {
    var DEFAULT_ENV = "dev"

    var env = yargs
            .alias("e", "env")
            .argv
            .env || DEFAULT_ENV

    app.use(require("morgan")("dev"))
    
    app.configs = require("./" + env)
    app.errors  = require("../errors")
}
