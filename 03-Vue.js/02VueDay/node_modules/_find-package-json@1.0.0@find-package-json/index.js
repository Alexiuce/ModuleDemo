'use strict';

var path = require('path')
  , fs = require('fs');

/**
 * Attempt to somewhat safely parse the JSON.
 *
 * @param {String} data JSON blob that needs to be parsed.
 * @returns {Object|false} Parsed JSON or false.
 * @api private
 */
function parse(data) {
  data = data.toString('utf-8');

  //
  // Remove a possible UTF-8 BOM (byte order marker) as this can lead to parse
  // values when passed in to the JSON.parse.
  //
  if (data.charCodeAt(0) === 0xFEFF) data = data.slice(1);

  try { return JSON.parse(data); }
  catch (e) { return false; }
}

/**
 * Find package.json files.
 *
 * @param {String} root The root directory we should start searching in.
 * @returns {Object} Iterator interface.
 * @api public
 */
module.exports = function find(root) {
  root = root || process.cwd();

  return {
    /**
     * Return the parsed package.json that we find a parent folder.
     *
     * @returns {Object} Value and indication if the iteration is done.
     * @api public
     */
    next: function next() {
      if (root === path.sep) return {
        value: undefined,
        done: true
      };

      var file = path.join(root, 'package.json')
        , data;

      root = path.resolve(root, '..');

      if (fs.existsSync(file) && (data = parse(fs.readFileSync(file)))) {
        data.__path = file;

        return {
          value: data,
          done: false
        };
      }

      return next();
    }
  };
};
