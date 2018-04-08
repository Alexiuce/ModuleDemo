const http = require('http');
const querystring = require('querystring');
const urlLib = require('url');
const fs = require('fs');

const server = http.createServer((req,res)=>{

  let user = {};
  let str = '';
  req.on('data',data=>str += data);

  req.on('end',()=>{
    const obj = urlLib.parse(req.url,true);
    const url = obj.pathname;
    const get_method = obj.query;
    const post_method = querystring.parse(str);
    console.log(req);
    if (url == '/user'){   // 请求api

      switch (get_method.act){
        case 'reg':
          if (user[get_method.user]){   // 已存在
               res.write('{"ok":false,"msg":"user already exist.. "}')
          }else {   //
               res.write('{"ok":true,"msg":"ok,  reg success "}')
          }
          break;
        case 'login':
          if (user[get_method.user]){
            if (user[get_method.user] != get_method.pass){
              res.write('{"ok":false, "msg":"username or password not right"}')
            }else {
              res.write('{"ok":true, "msg":"login success"}')
            }


          }else {
            res.write('{"ok":false,"msg":"the user not exist"}')
          }

          break;
        default:
          res.write('{"ok":false,"msg":"can not be know the act"}')
          res.end()
      }

    }else {   // 请求file
      const fliename = './www' + url;
      fs.readFile(fliename,(err,data)=>{
        if (err){
          res.write('404')
        }else {
          res.write(data)
        }
        res.end()
      })

    }

  });

});
server.listen(3333);
