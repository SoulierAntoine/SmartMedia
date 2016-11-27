"use strict"

module.exports = function(app) {
    return {
        count: require("./count")(app),
        download: require("./download")(app),
        upload: require("./upload")(app),
        list: require("./list")(app)
    }
};
