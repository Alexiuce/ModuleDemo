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


// hello.jade 标签下使用 | 表示原样输出内容
    // 标签后面使用点,表示此标签下面的任何子内容都使用原样输出
    // 也可以使用include 来引用js文件
    // 引用参数时,使用#{参数名}
    // - 表示这是一行代码 并且此行之下的行如果有代码,则都可以省略-

    // != 用在标签上,表示不需要转译html内容

let str = jade.renderFile('./forloop.jade',{pretty: true,arr:[1,2,3,4,5,6],ccc:'<div>this is ccc</div>'});

console.log(str);
//  ejs.renderFile('./home.ejs',{name:'alex'},(err,data)=>{
//     if (err) {
//         console.log('读取失败');
//     }else {
//         console.log(data);
//     }
// });

