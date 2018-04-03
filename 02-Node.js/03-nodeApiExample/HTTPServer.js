const http = require('http')

const server = http.createServer( (request, response) => {

  switch (request.url){
    case '/home':
      response.write("home...")
      break
    case '/index':
      response.write("index...")
      break
    case 'node':
      response.write("node...")
      break
    default:
     response.write("default...")
  }

  const s = "for my string"
  response.end(`hello node js ${s}`)
});
server.listen(3333)