

let arr = [1,2,3,4,5,56];

// for (let i = 0; i < arr.length; i++){
//     console.log(arr[i])
// }

/** 支持return  */
// arr.forEach((item)=>{
//
//     console.log(item);
// });
/** 不仅遍历数组内容,同时遍历数组属性 */
// for (item in arr){
//     console.log(item);
// }
/** 不能遍历对象,只支持数组 支持return */
// for (let val of arr){
//
//     console.log(val);
// }

/** 遍历对象属性*/
//let obj = {school:"bd", age: 23}
//
// for (let val of Object.keys(obj)){
//     console.log(val);
// }

/** filter 方法 example */

// let filterArray = arr.filter((item)=>{
//     return item < 3;
// })
//
// console.log(filterArray);

/** map 方法 example */

// let mapArray = arr.map((itme)=>{
//     return itme * 2;
// })
// console.log(mapArray);
/** includes 方法 : 判断是否包含元素 布尔类型返回值 */

// let result = arr.includes(5)
// console.log(result);

/** find 方法: 寻找元素 返回找到的结果(找到后就立刻返回),不改变数组, 未找到返回undefined */

// let findResult = arr.find((it,index)=>{
//      return it.toString().indexOf("9") > -1
// })
//
// console.log(findResult || "no result");

/** some 方法: 返回布尔值, 找到后停止 */
// let someResult = arr.some((it,index)=>{
//     return it.toString().indexOf('5') > -1
// })
// console.log(someResult);

/** every 方法: 返回布尔值, 结果为false时停止,并返回false */
// let everyResult = arr.every((item,index) =>{
//     return item > 5
// })
// console.log(everyResult);

/** reduce 方法 :
 *  function函数的 四个参数,不改变原数组
     * prev: 初始值(数组的第一个元素), 用来记记录一次循环的结果,
     * next: 下一个元素
     * index: 索引
     * item : 原数组
 * option: initValue :指定function的prev 初始化值
 * 返回叠加后的结果 */

// let reduceResult = arr.reduce((prev,next,index,item) => {
//     return  prev + next
// })
// console.log(reduceResult);
/** 带初始prev值的reduce  */
// let reduceResult = arr.reduce((prev,next,index,item) => {
//     return  prev + next
// },1);
// console.log(reduceResult);


/** 更改this指向
 *  call
 *  apply
 *  bind
 *  let that = this
 *  =>
 * */

/** 箭头函数
 *  省去function 关键字 如果没有{} 表达式就时返回值,有{}时,需要返回值则必须有return
 * */

// let f1 = b => b + 10;   // 一个参数, 有返回值
// let f2 = (b)=>{return b + 1}  // 同上
// console.log(f1(10));
// console.log(f2(2))

// let f3 = (a) =>{return (c)=>{ return a + c}}
//
// let result = f3(3)(3)
// console.log(result);
let f4 = a => b => b + a;  // 对于f3的简化写法

let s = f4(12)(10)
console.log(s);