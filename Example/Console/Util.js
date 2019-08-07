exports.consoleClear
  = console.clear;

exports.readline
  = function () {
      return require('readline');
    };

exports.cursorToImpl
  = function (readline, x, y) {
      readline.cursorTo(process.stdout, x, y);
    };

exports.logImpl
  = function (s) {
      process.stdout.write(s);
    };

exports.getRows
  = function () {
      return process.stdout.rows;
    };

exports.getColumns
  = function () {
      return process.stdout.columns;
    };
