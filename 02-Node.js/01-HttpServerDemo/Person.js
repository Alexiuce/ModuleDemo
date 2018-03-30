
let p_country = "china"

function say() {
  console.log("person say ...hello")
}

function Student(name,age) {
  console.log("student name is " + name + "age is :" + age)
  this.name = name
  this.age = age
  this.greet = function () {
    console.log("hello " + name)
  }
}

/** 导出 say 方法*/
// exports.say = say;
/** 导出 p_country */
// exports.country = p_country;
/** 导出Student 方法 */
// exports.student = Student;

/** 导出模型后,就不要使用上面的方式单独暴漏数据和方法了 */
module.exports = Student;