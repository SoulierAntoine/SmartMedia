/**
 * Created by soulierantoine on 24/11/2016.
 */

"use strict";

var sh = require("shelljs");


module.exports = function(app) {
    return function(req, res, next) {
        var baseDir = sh.pwd().stdout;
        var audioDir = "audio_files/";
        sh.cd(audioDir);
        var files = sh.ls() || [];
        sh.cd(baseDir);

        console.log("files: ", files);


        return res.json({
            "files":files
        })
    }
};
