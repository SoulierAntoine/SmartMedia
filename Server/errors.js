"use strict";

module.exports = {
    NOT_IMPLEMENTED: {
        status_code: 500,
        code_api: 1000,
        error: "API not implemented"
    },
    BAD_PARAMETER_URL: {
        status_code: 500,
        code_api: 1001,
        error: "Check parameter in url. It must not be null or empty"
    },
    BAD_BODY_PARAMETER: {
        status_code: 500,
        code_api: 1002,
        error: "Check body parameter. It must not be null or empty"
    },
    NO_DB_CONNECTION: {
        status_code: 500,
        code_api: 1003,
        error: "Missing database connection"
    }
};
