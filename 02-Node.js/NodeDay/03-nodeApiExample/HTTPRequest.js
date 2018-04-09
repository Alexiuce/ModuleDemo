let http = require('http');
let targetUrl = 'http://nodejs.cn';
let request =http.request(targetUrl,(response) => {
  "use strict";
  var s = ''
  response.on('data', (res) => {
    s += res
  })
  response.on('end',() => {
    console.log(s);
  })

});

request.on('error',(e)=>{
  "use strict";
  console.log('${e.message}');
});
request.end()