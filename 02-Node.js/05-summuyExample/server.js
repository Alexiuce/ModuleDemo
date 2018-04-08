const http = require('http');
const querystring = require('querystring');
const urlLib = require('url');
const fs = require('fs');

const server = http.createServer((req,res)=>{

  let str = '';
  req.on('data',(data)=>{
    str += data;
  });
  req.on('end',()=>{
    
  });

});
server.listen(3333);
