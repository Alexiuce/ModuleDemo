
// resolve :function  转向成功态
// reject :function 转向失败态


let p = new Promise((resolve,reject)=>{

    setTimeout(()=>{
        console.log(1)

    },2000)
});

// promise 实例有个then方法,有两个参数,分别对应resolve,和reject
/** Promise
 *  JS 原生提供
 *  
 * */


p.then(()=>{

},()=>{

})
console.log(2);


// 理解示例: 使用promise 封装ajax 请求

function myajax(url = '') {
    return new Promise((resolve,reject)=>{

        let request = new XMLHttpRequest();
        request.open('GET',url,true);

        request.onload = (data) =>{  // 请求成功
            resolve(data)
        }
        request.onerror = (err) => { // 请求失败
            reject(err)
        }

        request.send()
    })
}


// 使用
myajax('xxx.xxx.com/dfl').then((res)=>{  // 成功回调

    },
    (error)=>{  // 失败回调

    })