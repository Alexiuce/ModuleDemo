
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
// http_server.use(body_parser.json());

/**  会话管理 : cookie , session 等... */
let cookieParser = require('cookie-parser')

let session = require('express-session')

http_server.use(cookieParser('session_test'))

http_server.use(session({
    secret: 'session_test',
    resave: true,
    saveUninitialized: true
}))


http_server.get('/',function (request,response) {
    let user = {
        name: 'alex',
        age: 12,
        address: 'hangzhou'
    }
    request.session.user = user

    response.send('you has logined ... please visite /user get info')
});
http_server.get('/user', (request,response)=>{
    if (request.session.user) {
        let u = request.session.user
        response.send("welcome you : " + u.name)
    }else {
        response.send('you need visite / for login')
    }
})

/** 使用router 链式处理 */

// http_server.route('/book')
//     .get( (reqeust, response) => {
//     response.send('give you a boook')
// } ).post((request,response)=>{
//     response.send('post you a book')
// })


/** 路径可以支持正则匹配*/

// http_server.get('/ab?cd',(request, response) => {
//     response.send('ab?cd')
// })



// http_server.use('/',function (request, response, next) {
//   // console.log(request.query);  获取get请求参数
//    console.log(request.body)  // 获取post请求参数
//   next();
// });
//
// http_server.post('/',function (request, response) {
//   response.send(request.body);
// });

http_server.listen(3333);


/** ||||基本语法练习|||||| */
// let array = [1,2,3,4]

// let double_array = array.map(function (value,index) {
//   return value * 2
// });


// for (i = 0; i < double_array.length; i ++){
//   console.log(double_array[i]);
// }

// array.push(9)
// let result = isExistInArray(array,9)
// console.log(result);

// function isExistInArray(array,target) {
//   let count = array.length
//   for (i = 0; i < count; i++){
//     if (array[i] === target) {
//       return true
//     }
//   }
//   return false
// }


// let person = require('./Person');
// console.log(person.country);
// person.say();
// person.student('alwx',20);
// let s = new person("alex",33);
// s.greet();