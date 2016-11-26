"use strict";

var sh = require("shelljs");


module.exports = function(app) {
	return function(req, res, next) {
        var baseDir = sh.pwd().stdout;
        var audioDir = "audio_files/";
		sh.cd(audioDir);
		var files = sh.ls() || [];
		sh.cd(baseDir);

		return res.json({
            "response":"True",
			"numberOfFiles":files.length
		})
    }
};