let eventEmitter = require('events').EventEmitter

let em = new eventEmitter()

em.on('123',function (name) {
  console.log(name + 'l~~~~');
} )

em.emit('123','alex')
