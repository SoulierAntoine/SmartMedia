"use strict";

var sh = require("shelljs");

module.exports = function(app) {
	return function(req, res, next) {
		if (typeof req.query.file === "undefined") {
			return res.json({
				"status":"400",
				"message":"Bad request, the paramater 'file' must not be empty"
			})
		}

		var requestedFile = decodeURI(req.query.file);

		var baseDir = sh.pwd().stdout;
		var audioDir = "audio_files";
		var file = baseDir + "/" + audioDir + "/" + requestedFile;

		console.log("file: ", file);

		res.download(file, function (err) {
			if (err) {
				return res.json({
					"status":"404",
					"message":"File was not found"
				})
			}
		});
    }
};