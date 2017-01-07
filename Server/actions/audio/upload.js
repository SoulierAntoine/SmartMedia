/**
 * Created by soulierantoine on 27/11/2016.
 */


"use strict";


module.exports = function(app) {
    return function(req, res, next) {
        if (!req.files) {
            return res.json({
                "status":"400",
                "message":"Bad request, no files was uploaded."
            })
        }

        var file = req.files.smartMediaFile;

        file.mv("audio_files/" + file.name, function(err) {
            if (err) {
                res.status(500).send(err);
            }
            else {
                return res.json({
                    "status":"200",
                    "message":"File uploaded successfully"
                })
            }
        });
    }
};
