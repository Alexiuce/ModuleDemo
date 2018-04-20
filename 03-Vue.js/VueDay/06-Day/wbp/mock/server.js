const http = require('http');
const fs = require('fs');
const url = require('url');

const sliders = require('./sliders');

let books = require('./book.json');

const PageSize = 5

const server = http.createServer((req, res) => {

  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader('Content-Type', 'application/json;charset=utf8')
  res.setHeader("Access-Control-Allow-Headers", "Content-Type,Content-Length, Authorization, Accept,X-Requested-With");
  res.setHeader("Access-Control-Allow-Methods", "PUT,POST,GET,DELETE,OPTIONS");
  res.setHeader("X-Powered-By", ' 3.2.1')
  if (req.method === "OPTIONS") return res.end("200");

  const {pathname, query} = url.parse(req.url, true);

  /* 轮播图 */
  if (pathname === '/sliders') {
    return res.end(JSON.stringify(sliders))
  }

  if (pathname === '/page') {
    // 获取请求参数 offSet
    const offSet = parseInt(query.offSet) || 0
    const data = books.slice(offSet, offSet + PageSize);
    let hasMore = books.length > offSet + PageSize;

    setTimeout(() => {
      return res.end(JSON.stringify({hasMore, data}))
    }, 3000);
  }

  /*热门图书*/
  if (pathname === '/hot') {
    setTimeout(() => {
      return res.end(JSON.stringify(books))
    }, 3000)
  }

  /*图书的操作: 增删改查 */
  if (pathname === '/book') {
    const bookID = parseInt(query.id)
    switch (req.method) {
      case 'GET':
        if (bookID >= 0) {  // 查询id图书
          const b = books.filter((item) => {
            return parseInt(item.bookId) == bookID
          });
          return res.end(JSON.stringify(b[0] || {}))
        } else {   // 返回所有图书
          return res.end(JSON.stringify(books))
        }
        break;
      case 'POST':
        break;
      case 'PUT':
        if (bookID >= 0) {
          let str = ''
          req.on('data', (data) => {
            str += data
          })
          req.on('end', () => {
            const book = JSON.parse(str)
            books = books.map((item) => {
              if (item.bookId == book.bookId) return book
              return item
            })
            return res.end(JSON.stringify(book))
          })

        } else {

        }
        break;
      case 'DELETE':
        console.log(bookID);
        books = books.filter((item) => item.bookId != bookID)
        return res.end(JSON.stringify({}));
        break;

    }
  }
});
server.listen(3456);




