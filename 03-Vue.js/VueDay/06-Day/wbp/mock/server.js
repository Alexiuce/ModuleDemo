const http = require('http');
const fs = require('fs');
const url = require('url');

const sliders = require('./sliders');

const books = require('./book.json');

const server = http.createServer((req,res)=>{

  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type,Content-Length, Authorization, Accept,X-Requested-With");
  res.setHeader("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
  res.setHeader("X-Powered-By",' 3.2.1')
  if(req.method=="OPTIONS") return res.end(200);

  const {pathname,query} = url.parse(req.url);

  if (pathname === '/sliders'){
    return res.end(JSON.stringify(sliders))
  }

  if (pathname === '/hot'){
       return res.end(JSON.stringify(books))
  }

});
server.listen(3456);




