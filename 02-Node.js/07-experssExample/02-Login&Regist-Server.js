const express = require('express');
const experssStatic = require('express-static');






const server = express();

let users = {
  'zhangsan':'123',
  'lisi':'345'
};


server.get('/login',(req,res)=>{

  let u = req.query['user']
  let p = req.query['pass']

  if (users[u] == null){

    res.send({ok:false,msg:'user not exist..'})
  }else {
    if (users[u] != p){
      res.send({ok:false,msg:'password or username not right'})
    }else {
      res.send({ok:true,msg:'success. for login '})
    }
  }

});



server.use(experssStatic('./www'));



server.listen(9090);