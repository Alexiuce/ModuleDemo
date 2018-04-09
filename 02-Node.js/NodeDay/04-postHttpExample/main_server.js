const http = require('http');
const fs = require('fs');
const querystring = require('querystring');
const urlLib = require('url');

const server = http.createServer((req,res) => {

  switch (req.method){
    case "GET":
      // Get
      let getparams = urlLib.parse(req.url,true);
      let url = getparams.pathname;
      const file_path = './www' + url + '.html';
      fs.readFile(file_path,(err,context)=>{
        if (err){
          res.write(`${url} path not found....` )
        }else {
          res.write(context);
        }
        res.end()
      });
      break;
    case "POST":
      let ps = ''
      req.on('data',(data)=>{
        ps += data
      });
      req.on('end', ()=>{
        console.log(ps);
      });
      res.end()
      break;
    default:
      req.end()
  }

  // Post
} );
server.listen(3333);