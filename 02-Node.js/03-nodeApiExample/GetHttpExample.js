const http = require('http');

const queryString = require('querystring');

const urlLib = require('url');

const server = http.createServer((req,res)=>{
  "use strict";


  let url = urlLib.parse(req.url,true);
  console.log(url);
  let s = "user=alex&pwd=123";
  let json = queryString.parse(s);
  console.log(json);
  res.end('hello .....');

});

server.listen(3456);