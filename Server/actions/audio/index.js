"use strict"

module.exports = function(app) {
    return {
        count: require("./count")(app),
        download: require("./download")(app),
        list: require("./list")(app)
    }
};
