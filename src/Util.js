exports.consoleClear = console.clear;

exports.logNoNewlineImpl = function (s) { process.stdout.write(s); };
