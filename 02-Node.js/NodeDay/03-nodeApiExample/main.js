
/*
let url = require('url');
let result = url.parse('https://www.cnblogs.com/lpbottle/p/7733397.html');

console.log(result);
*/


/*
let querystring = require('querystring')


let  s = querystring.escape("和哈");
console.log(s);
let old = querystring.unescape(s);
console.log(old);
*/
/*

var pet = {
  "name": "alex",
  "age": 12,
  "say": function () {
    console.log(this.name)
    console.log(this)
  }
}

pet.say()
*/

/** call 改变this 上下文 */
/*
var pet = {
  'name' : 'wang cai',
  'speak': function () {
    console.log(this.name);
  }
};

var dog = {
  'name': 'little strong'
}

pet.speak()
pet.speak.call(dog)
*/

/** apply demo*/

/*function Pet(name) {
  this.name = name
  this.speak = function () {
    console.log(this.name);
  }
}

function Dog(name) {
  // Pet.call(this,name)
  Pet.apply(this,[name])
}

var dog = new Dog('xx')
dog.speak()*/
