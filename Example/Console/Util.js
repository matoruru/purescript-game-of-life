exports.consoleClear
  = function () {
      console.clear();
      return {};
    };

exports.readline
  = function () {
      return require('readline');
    };

exports.cursorTo
  = function (readline) {
      return function (x) {
        return function (y) {
          return function () {
            readline.cursorTo(process.stdout, x, y);
            return {};
          };
        };
      };
    };

exports.logImpl
  = function (s) {
      return function() {
        process.stdout.write(s);
        return {};
      };
    };

exports.getRows
  = function () {
      return process.stdout.rows;
    };

exports.getColumns
  = function () {
      return process.stdout.columns;
    };
