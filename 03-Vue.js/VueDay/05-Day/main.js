

// 导入 需要使用解构赋值的方式获取导入内容
/* improt 具有提升效果,会放到文件顶部 */

// import {strHome} from './home.js'
/* 通过对象方式 使用 导入的模块 : 使用 as */
import * as obj from './home.js'

import p from './profile.js'

console.log(p);


console.log(obj.strHome);
// console.log(strProfile);