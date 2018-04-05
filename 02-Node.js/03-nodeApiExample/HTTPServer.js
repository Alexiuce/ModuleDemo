const http = require('http')
const fs = require('fs')

const server = http.createServer( (request, response) => {

  fs.readFile('./www/index.html',(err,data)=>{
    "use strict";

    response.write(data)

    const s = "for my string"
    response.end(`hello node js ${s}`)

  })

});
server.listen(3333)