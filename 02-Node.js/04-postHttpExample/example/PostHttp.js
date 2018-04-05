const http = require('http');

const server = http.createServer((req,res) => {

  let result = "";
  // 接收到数据事件
  req.on('data',(data) => {
    result += data
  });
  // 接收数据完毕事件
  req.on('end', () => {
    console.log(result);
  })


});


server.listen(3333);