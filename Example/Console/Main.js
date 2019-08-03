exports.consoleClear
  = console.clear;

exports.cursorToImpl
  = function (x, y) {
      require('readline').cursorTo(process.stdout, x, y);
    };

exports.logNoNewlineImpl
  = function (s) {
      process.stdout.write(s);
    };

exports.getRows
  = function () {
      return process.stdout.rows - 1;
    };

exports.getColumns
  = function () {
      return process.stdout.columns;
    };
