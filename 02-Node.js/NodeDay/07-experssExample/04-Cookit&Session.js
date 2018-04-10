const express = require('express');
const cookieParser = require('cookie-parser');
const cookieSession = require('cookie-session');

const server = express()


server.use(cookieParser('abc'))
server.use(cookieSession({
    name:'sss',   // 修改默认的session名称
    keys:['abc','bbb','ccc','ddd'],   // 循环加密的数组
    maxAge:2*3600*1000   // session的有效时间
}))

server.use('/aaa',(req,res)=>{

    /** 发送cookit
     * req.secret = '签名密钥'
     * res.cookie(名,值,{path:指定路径才会给有此cookie,maxAge:最大有效时间(毫秒),signed:是否进行签名})*/
    // req.secret = 'abc'; // cookieParser() 与此作用相同
    res.cookie('user','alex',{path:'/aaa',maxAge:30*24*3600*1000,signed:true});  // cookie key value 键值对 方式


    /** 读取cookie : 使用cookie-parser */
    // console.log(req.cookies);   // 未签名的cookie
    // console.log(req.signedCookies);  // 签名的cookie



    // 设置session
    // if (req.session['ct']){
    //     req.session['ct']++
    // } else {
    //     req.session['ct'] = 1
    // }
    // console.log(req.session);
    res.send('ok');
});

server.use('/bbb',(req,res)=>{
    /** 删除cookie  */
    res.clearCookie('user');
    res.send('delete cookie');
    /** 删除session  */
    // delete req.session['ct'];
    // console.log(req.session);
    // res.send('delete session~~')
});

server.listen(9080);