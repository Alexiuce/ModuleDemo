
let http = require('http')

http.createServer(function (request, response) {
  response.write('h~~~~h~~~')
  response.end()
}).listen(3333)

