let http = require('http')

let server = http.createServer(function (request, response) {
  const s = "for my string"
  response.end('hello node js ${s}')
});
server.listen(3333)