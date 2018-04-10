

function Girl() {
    this._event = {}

}

Girl.prototype.on = function (eventName,callback) {
    if (this._event[eventName]){
        this._event[eventName].push(callback)
    } else {
        this._event[eventName] = [callback]
    }
};


/** ... 在形参中,表示剩余运算符(代表剩余的其他参数),在实参中表示展开运算符(将所有参数都一次展开) */
Girl.prototype.emit = function (eventName,...args) {
    if (this._event[eventName]){
        this._event[eventName].forEach(cb=>cb(...args))
    }
};

let g = new Girl();

let cry = (...arg)=>{
    console.log(...arg + 'cry....');
};
let eat = (...arg)=>{
    console.log(...arg +'eat....');
};
let buy = (...arg)=>{
    console.log(...arg + 'buy....');
};


g.on('shilian',cry);
g.on('shilian',eat);
g.on('shilian',buy);

g.emit('shilian','alex','tian');