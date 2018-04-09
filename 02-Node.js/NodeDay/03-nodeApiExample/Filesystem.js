const fs = require('fs')


/** 读取文件 */
fs.readFile('abc.txt',(err,data)=>{
  "use strict";
  console.log(data);
})

/** 写内容到文件 */
fs.writeFile('dec.txt','this is new file ...', (err)=>{
  "use strict";
  if (err) {
    console.log("error")
  }
})