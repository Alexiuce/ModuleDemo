
/**  1 使用node.js 内置的http模块创建http sever 示例
let http = require('http')

http.createServer(function (request, response) {
  response.write('h~~~~h~~~')
  response.end()
}).listen(3333)
*/

/** 2 使用express模块创建http server */

let body_parser = require('body-parser');
let express = require('express');

let http_server = express();
// post 请求方式: www-form-urlencoded
// http_server.use(body_parser.urlencoded({extended:true}));

// post 请求方式: application/json
http_server.use(body_parser.json());

// http_server.get('/node',function (request,response) {
//        response.send('node.js....')
// });

http_server.use('/',function (request, response, next) {
  // console.log(request.query);  获取get请求参数
   console.log(request.body)  // 获取post请求参数

  next();
});

http_server.post('/',function (request, response) {
  response.send(request.body);
});

http_server.listen(3333);



let array = [1,2,3,4]

let double_array = array.map(function (value,index) {
  return value * 2
});


for (i = 0; i < double_array.length; i ++){
  console.log(double_array[i]);
}

array.push(9)
let result = isExistInArray(array,9)
console.log(result);

function isExistInArray(array,target) {
  let count = array.length
  for (i = 0; i < count; i++){
    if (array[i] == target) {
      return true
    }
  }
  return false
}
