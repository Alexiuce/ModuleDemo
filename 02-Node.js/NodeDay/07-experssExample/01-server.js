const express = require('express');

const server = express();


/*
server.use('/',(req,res)=>{
  // res.send('Hello experss');   // 支持返回对象 ,例如 {age:100,name:"hello"}
  res.send({age:128,name:'ft'});
  res.end();
});*/


server.get('/',(req,res) =>{

  console.log('get request');
});
server.post('/',(req,res) =>{
  console.log('post request');
});


server.listen(8899);