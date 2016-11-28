"use strict";

var router      = require('express').Router();


module.exports  = function(app) {
    router.get('/count', app.actions.audio.count);
    router.get('/download', app.actions.audio.download);
    router.post('/upload', app.actions.audio.upload);
    router.get('/list', app.actions.audio.list);
    return router
};