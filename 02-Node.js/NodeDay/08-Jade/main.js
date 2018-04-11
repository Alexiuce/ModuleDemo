const jade = require('jade');
const ejs = require('ejs');



/** jade
 * 根据缩进决定层级关系
 * 属性使用()来设置,多属性之间使用逗号分割
 * 内容需要与标签之间使用空格分离
 * style也可以使用json方式 : {}
 * class 也可以用数组方式: ['a','b','c']
 * 标签属性通过使用&attribute,可以应用json格式 div&attribute({title:'node',id: 'app'})
 * */

// let str = jade.render('html');
let str = jade.renderFile('./home.jade',{pretty: true});

console.log(str);
//  ejs.renderFile('./home.ejs',{name:'alex'},(err,data)=>{
//     if (err) {
//         console.log('读取失败');
//     }else {
//         console.log(data);
//     }
// });

