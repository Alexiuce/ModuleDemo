const express = require('express');
const expressStatic = require('express-static');
// const bodyParser = require('body-parser');

// 导入自定义的中间件
const mybody = require('./CustomMiddleModule');

const server = express();
server.listen(8899);


/* urlencoded : 有两个参数:
* 1. extended: //  布尔类型,是否开启扩展模式
* 2. limit:    // 限制post body的大小,默认为100k, (100 * 1024)
* */
// server.use(bodyParser.urlencoded({
// extended: false
// }));

// 使用自定义的中间件处理 post body 数据
server.use(mybody)

// Get
server.get('/',(req,res)=>{
    console.log(req.query);
});


// Post
server.post('/',(req,res)=>{
    console.log(req.body);
});


