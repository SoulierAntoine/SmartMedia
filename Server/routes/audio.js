"use strict";

var router      = require('express').Router(),
    bodyparser  = require('body-parser').json();


module.exports  = function(app) {
    router.get('/count', app.actions.audio.count);
    router.get('/download', app.actions.audio.download);
    router.get('/list', app.actions.audio.list);
    return router
};