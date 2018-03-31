let http = require('http')

let server = http.createServer(function (request, response) {
  response.end('hello node js')
});
server.listen(3333)