/**
 * Created by soulierantoine on 27/11/2016.
 */


"use strict";

var fileUpload = require('express-fileupload');
app.use(fileUpload());

module.exports = function(app) {
    return function(req, res, next) {
        if (typeof req.files === "undefined") {
            return res.json({
                "status":"400",
                "message":"Bad request, no files was uploaded."
            })
        }

        var sampleFile;
        sampleFile = req.files.sampleFile;
        console.log("sampleFile: ", sampleFile);

        /* sampleFile.mv('/audio_files/filename.jpg', function(err) {
            if (err) {
                res.status(500).send(err);
            }
            else {
                res.send('File uploaded!');
            }
        }); */

        return res.json({
            "status":"200",
            "message":"File uploaded"
        })
    }
};
