exports.consoleClear = console.clear;

exports.logNoNewlineImpl = function (s) { process.stdout.write(s); };

exports.getRows = function () { return process.stdout.rows };

exports.getColumns = function () { return process.stdout.columns };
