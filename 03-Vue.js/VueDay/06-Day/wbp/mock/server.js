const http = require('http');
const fs = require('fs');
const url = require('url');

const sliders = require('./sliders');

let books = require('./book.json');

const server = http.createServer((req,res)=>{

  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type,Content-Length, Authorization, Accept,X-Requested-With");
  res.setHeader("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
  res.setHeader("X-Powered-By",' 3.2.1')
  if(req.method === "OPTIONS") return res.end("200");

  const {pathname,query} = url.parse(req.url,true);

  /* 轮播图 */
  if (pathname === '/sliders'){
    return res.end(JSON.stringify(sliders))
  }

  /*热门图书*/
  if (pathname === '/hot'){
       return res.end(JSON.stringify(books))
  }

  /*图书的操作: 增删改查 */
  if (pathname === '/book'){
    const bookID = parseInt(query.id)
    switch (req.method){
      case 'GET':
        if (bookID){  // 查询id图书
          const b = books.filter((item) =>{return parseInt(item.bookId) == bookID})
          return res.end(JSON.stringify(b))
        }else {   // 返回所有图书
           return res.end(JSON.stringify(books))
        }
        break;
      case 'POST':
        break;
      case 'DELETE':
        console.log(bookID);
        books = books.filter((item)=>item.bookId != bookID)
        break;

    }
  }
});
server.listen(3456);




