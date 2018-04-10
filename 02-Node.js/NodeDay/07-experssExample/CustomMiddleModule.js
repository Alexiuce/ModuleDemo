const queryString = require('querystring');

module.exports = (req, res, next) => {

    let s = '';
    req.on('data', (data) => {
        s += data;
    });
    req.on('end', () => {
        req.body = queryString.parse(s)
        next();
    })

}