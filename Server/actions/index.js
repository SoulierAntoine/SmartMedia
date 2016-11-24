"use strict";

module.exports = function(app) {
    app.actions = {};
    app.actions.audio = require('./audio')(app);
}
