var request = require('browser-request')

module.exports = function (uri, callback) {
  request(uri, function (err, response, body) {
    if (err) {
      return callback(err)
    }

    try {
      var parsed = JSON.parse(body)
    } catch (e) {
      return callback(e)
    }

    return callback(null, parsed)
  })
}
