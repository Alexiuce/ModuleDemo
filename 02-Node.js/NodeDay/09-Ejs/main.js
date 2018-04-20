const ejs = require('ejs');



/** 参数: 文件路径,参数对象,回调方法(err, data) */
ejs.renderFile('./01.ejs',{name:100,json:{name:'alex',favs:['study','camera','book','holiday']}},(err, data)=>{

    console.log(data);
});