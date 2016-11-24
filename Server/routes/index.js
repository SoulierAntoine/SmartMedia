"use strict";

module.exports = function(app){
    var baseUrlAPI = '/api';
    app.use(baseUrlAPI.concat('/audio'), require('./audio')(app));
};
