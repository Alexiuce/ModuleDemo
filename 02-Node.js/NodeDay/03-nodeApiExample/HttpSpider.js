let http = require('http');
let targetUrl = 'http://nodejs.cn';

http.get(targetUrl, (response) => {
  var html = ''
  response.on('data', (data) => {
    html += data
  })
  response.on('end', () =>{
    console.log(html)
  })
  
}).on('error', () => {
  console.log('get html error')
});