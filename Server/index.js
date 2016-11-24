"use strict";

require("./global");

var express = require("express"),
    app     = express();

var server  = require("http").createServer(app);

require("./configs")(app);
require("./actions")(app);
require("./routes")(app);


(function start() {
    server.listen(app.configs.server.port, app.configs.server.adress);
    console.log('Server listening on port :port'.replace(':port', app.configs.server.port))
} ());