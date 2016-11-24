"use strict";

global.isNull = function (value) {
    return value === null || value == undefined;
};

global.isNullOrEmpty = function (str) {
    return str === null || str == undefined || str.match(/^ *$/) !== null;
};

global.isEmailValid = function (email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
};

global.isDateValid  = function (date) {
    return ((Object.prototype.toString.call(date) === "[object Date]") && (!isNaN(date.getTime())));
};
