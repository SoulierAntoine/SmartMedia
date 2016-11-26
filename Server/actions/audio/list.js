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
        var sounds = sh.ls() || [];
        sh.cd(baseDir);

        var files = [];

        sounds.forEach(function(sound) {
            var file = {};

            // Doesn't remove the separator "."
            var res = sound.split(/(\.)/);
            file.extension = res.pop().toLowerCase();

            // Join array without adding anything, and get rid of the last char
            file.title = res.join("").slice(0, -1);
            
            files.push(file);
        });

        return res.json({
            "response":"True",
            "files":files
        })
    }
};
